STHipChatStatusUpdater
=============

A simple injectable library that lets you update your HipChat status message programmatically.

Execute HipChat like so:

`DYLD_INSERT_LIBRARIES=$PATHTOLIB/STHipChatStatusUpdater.dylib open -a HipChat`

… and it will await further instruction.

Notifications sent to the `NSDistributedNotificationCenter` with name `STHipChatStatusUpdate` will update your status message using the value for the key `status` in `userInfo`.

Here's one I prepared earlier:
[STiTunesHipChatStatusUpdater](https://github.com/cysp/iTunesNotifier/tree/STHipChatStatusUpdater)
