import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import { GenericUplink } from './Uplink';

export const MalfunctionModulePicker = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    processingTime,
  } = data;
  return (
    <Window
      width={620}
      height={525}
      theme="malfunction"
      resizable>
      <Window.Content scrollable>
        <GenericUplink
          currencyAmount={processingTime}
          currencySymbol="PT" />
      </Window.Content>
    </Window>
  );
};
