import { toFixed } from 'common/math';
import { decodeHtmlEntities } from 'common/string';
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from "tgui/backend";
import { Box, Button, LabeledList, NumberInput, Section } from "tgui/components";
import { Window } from "tgui/layouts";
import { InterfaceLockNoticeBox } from 'tgui/interfaces/common/InterfaceLockNoticeBox';
import { Vent, Scrubber } from 'tgui/interfaces/common/AtmosControls';

export const AirAlarm = (props, context) => {
  return (
    <Window
      width={440}
      height={650}
      resizable>
      <Window.Content scrollable>
        <AirAlarmContent />
      </Window.Content>
    </Window>
  );
};

export const AirAlarmContent = (props, context) => {
  const { act, data } = useBackend(context);
  const unlocked
    = !(data.locked && !data.siliconUser)
    || (data.remoteConnection && data.remoteAccess);
  return (
    <Fragment>
      <InterfaceLockNoticeBox />
      <AirAlarmStatus />
      {unlocked && (
        <AirAlarmControl />
      )}
    </Fragment>
  );
};

const AirAlarmStatus = (props, context) => {
  const { data } = useBackend(context);
  const entries = (data.environment || [])
    .filter(entry => entry.value >= 0.01);
  const dangerMap = {
    0: {
      color: 'good',
      localStatusText: 'Optimal',
    },
    1: {
      color: 'average',
      localStatusText: 'Caution',
    },
    2: {
      color: 'bad',
      localStatusText: 'Danger (Internals Required)',
    },
  };
  const localStatus = dangerMap[data.danger_level] || dangerMap[0];
  return (
    <Section title="Air Status">
      <LabeledList>
        {entries.length > 0 && (
          <Fragment>
            {entries.map(entry => {
              const status = dangerMap[entry.danger_level] || dangerMap[0];
              return (
                <LabeledList.Item
                  key={entry.name}
                  label={entry.name}
                  color={status.color}>
                  {toFixed(entry.value, 2)}{entry.unit}
                </LabeledList.Item>
              );
            })}
            <LabeledList.Item
              label="Local status"
              color={localStatus.color}>
              {localStatus.localStatusText}
            </LabeledList.Item>
            <LabeledList.Item
              label="Area status"
              color={data.atmos_alarm || data.fire_alarm ? 'bad' : 'good'}>
              {data.atmos_alarm && 'Atmosphere Alarm'
                || data.fire_alarm && 'Fire Alarm'
                || 'Nominal'}
            </LabeledList.Item>
          </Fragment>
        ) || (
          <LabeledList.Item
            label="Warning"
            color="bad">
            Cannot obtain air sample for analysis.
          </LabeledList.Item>
        )}
        {!!data.emagged && (
          <LabeledList.Item
            label="Warning"
            color="bad">
            Safety measures offline. Device may exhibit abnormal behavior.
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};

const AIR_ALARM_ROUTES = {
  home: {
    title: 'Air Controls',
    component: () => AirAlarmControlHome,
  },
  vents: {
    title: 'Vent Controls',
    component: () => AirAlarmControlVents,
  },
  scrubbers: {
    title: 'Scrubber Controls',
    component: () => AirAlarmControlScrubbers,
  },
  modes: {
    title: 'Operating Mode',
    component: () => AirAlarmControlModes,
  },
  thresholds: {
    title: 'Alarm Thresholds',
    component: () => AirAlarmControlThresholds,
  },
};

const AirAlarmControl = (props, context) => {
  const [screen, setScreen] = useLocalState(context, 'screen');
  const route = AIR_ALARM_ROUTES[screen] || AIR_ALARM_ROUTES.home;
  const Component = route.component();
  return (
    <Section
      title={route.title}
      buttons={screen && (
        <Button
          icon="arrow-left"
          content="Back"
          onClick={() => setScreen()} />
      )}>
      <Component />
    </Section>
  );
};


//  Home screen
// --------------------------------------------------------

const AirAlarmControlHome = (props, context) => {
  const { act, data } = useBackend(context);
  const [screen, setScreen] = useLocalState(context, 'screen');
  const {
    mode,
    rcon,
    atmos_alarm,
  } = data;
  return (
    <Fragment>
      <LabeledList>
        <LabeledList.Item
          label="Remote Control"
        >
          <Button.Checkbox
            content="Disabled"
            checked={rcon === 1}
            onClick={() => act("rcon", { rcon: 1 })}
          />
          <Button.Checkbox
            content="Auto"
            checked={rcon === 2}
            onClick={() => act("rcon", { rcon: 2 })}
          />
          <Button.Checkbox
            content="Enabled"
            checked={rcon === 3}
            onClick={() => act("rcon", { rcon: 3 })}
          />
        </LabeledList.Item>
        <LabeledList.Item
          label="Temperature"
        >
          <NumberInput
            width="75px"
            value={data.target_temperature}
            unit="C"
            onChange={(e, value) => act("temperature", {
              val: value,
            })}
          />
          <Button
            icon="undo"
            content="Reset"
            onClick={() => act("temperature", {
              val: 20,
            })}
          />
        </LabeledList.Item>
      </LabeledList>
      <Box mt={2} />
      <Button
        icon={atmos_alarm
          ? 'exclamation-triangle'
          : 'exclamation'}
        color={atmos_alarm && 'caution'}
        content="Area Atmosphere Alarm"
        onClick={() => act(atmos_alarm ? 'reset' : 'alarm')} />
      <Box mt={1} />
      <Button
        icon={mode === 3
          ? 'exclamation-triangle'
          : 'exclamation'}
        color={mode === 3 && 'danger'}
        content="Panic Siphon"
        onClick={() => act('mode', {
          mode: mode === 3 ? 1 : 3,
        })} />
      <Box mt={2} />
      <Button
        icon="sign-out-alt"
        content="Vent Controls"
        onClick={() => setScreen('vents')} />
      <Box mt={1} />
      <Button
        icon="filter"
        content="Scrubber Controls"
        onClick={() => setScreen('scrubbers')} />
      <Box mt={1} />
      <Button
        icon="cog"
        content="Operating Mode"
        onClick={() => setScreen('modes')} />
      <Box mt={1} />
      <Button
        icon="chart-bar"
        content="Alarm Thresholds"
        onClick={() => setScreen('thresholds')} />
    </Fragment>
  );
};


//  Vents
// --------------------------------------------------------

const AirAlarmControlVents = (props, context) => {
  const { data } = useBackend(context);
  const { vents } = data;
  if (!vents || vents.length === 0) {
    return 'Nothing to show';
  }
  return vents.map(vent => (
    <Vent
      key={vent.id_tag}
      vent={vent} />
  ));
};

//  Scrubbers
// --------------------------------------------------------

const AirAlarmControlScrubbers = (props, context) => {
  const { data } = useBackend(context);
  const { scrubbers } = data;
  if (!scrubbers || scrubbers.length === 0) {
    return 'Nothing to show';
  }
  return scrubbers.map(scrubber => (
    <Scrubber
      key={scrubber.id_tag}
      scrubber={scrubber} />
  ));
};

//  Modes
// --------------------------------------------------------

const AirAlarmControlModes = (props, context) => {
  const { act, data } = useBackend(context);
  const { mode, modes } = data;
  if (!modes || modes.length === 0) {
    return 'Nothing to show';
  }

  return modes.map(e => {
    e.selected = e.mode === mode;
    return e;
  }).map(mode => (
    <Fragment key={mode.mode}>
      <Button
        icon={mode.selected ? 'check-square-o' : 'square-o'}
        selected={mode.selected}
        color={mode.selected && mode.danger && 'danger'}
        content={mode.name}
        onClick={() => act('mode', { mode: mode.mode })} />
      <Box mt={1} />
    </Fragment>
  ));
};


//  Thresholds
// --------------------------------------------------------

const AirAlarmControlThresholds = (props, context) => {
  const { act, data } = useBackend(context);
  const { thresholds } = data;
  return (
    <table
      className="LabeledList"
      style={{ width: '100%' }}>
      <thead>
        <tr>
          <td />
          <td className="color-bad">min2</td>
          <td className="color-average">min1</td>
          <td className="color-average">max1</td>
          <td className="color-bad">max2</td>
        </tr>
      </thead>
      <tbody>
        {thresholds.map(threshold => (
          <tr key={threshold.name}>
            <td className="LabeledList__label">
              {decodeHtmlEntities(threshold.name)}
            </td>
            {threshold.settings.map(setting => (
              <td key={setting.val}>
                <Button
                  content={toFixed(setting.selected, 2)}
                  onClick={() => act('set_threshold', {
                    env: setting.env,
                    var: setting.val,
                  })} />
              </td>
            ))}
          </tr>
        ))}
      </tbody>
    </table>
  );
};
