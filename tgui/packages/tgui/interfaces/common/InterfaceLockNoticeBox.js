import { useBackend } from "tgui/backend";
import { Button, Flex, NoticeBox } from "tgui/components";

/**
 * This component by expects the following fields to be returned
 * from ui_data:
 *
 * - siliconUser: boolean
 * - locked: boolean
 *
 * And expects the following ui_act action to be implemented:
 *
 * - lock - for toggling the lock as a silicon user.
 *
 * All props can be redefined if you want custom behavior, but
 * it's preferred to stick to defaults.
 */
export const InterfaceLockNoticeBox = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    siliconUser = data.siliconUser,
    remoteConnection = data.remoteConnection,
    remoteAccess = data.remoteAccess,
    locked = data.locked,
    onLockStatusChange = () => act('lock'),
    accessText = 'an ID card',
  } = props;
  // For silicon users
  if (siliconUser) {
    return (
      <NoticeBox color={siliconUser && 'grey'}>
        <Flex align="center">
          <Flex.Item>
            Interface lock status:
          </Flex.Item>
          <Flex.Item grow={1} />
          <Flex.Item>
            <Button
              m={0}
              color={locked ? 'red' : 'green'}
              icon={locked ? 'lock' : 'unlock'}
              content={locked ? 'Locked' : 'Unlocked'}
              onClick={() => {
                if (onLockStatusChange) {
                  onLockStatusChange(!locked);
                }
              }} />
          </Flex.Item>
        </Flex>
      </NoticeBox>
    );
  }
  if (remoteConnection) {
    return (
      <NoticeBox>
        Remote Access: {(!!remoteAccess && "Full Access") || "Read-only"}
      </NoticeBox>
    );
  }
  // For everyone else
  { return (
    <NoticeBox>
      Swipe {accessText}{' '}
      to {locked ? 'unlock' : 'lock'} this interface.
    </NoticeBox>
  ); }
};
