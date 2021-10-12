function [secs,key] = KbGet(limit, varargin)

%[secs key] = KbGet([limit])

%?·å??ä¸?ä¸?????ï¼?å¹¶è???å¾??°è?ä¸??????¶ç???¶é??

%??ä»¥è?¾ç½®limit?¥é???¶æ??????åº??¶é?´ï?è¶??¶å??è¿???key = 0

%ç²¾åº¦æ¯?KbStrokeWaité«?

%author: zbg 2015-2

%???? http://my.oschina.net/u/1387924/blog/379421

    if nargin == 0

        limit = inf;

    end

    [~, oldsecs, oldkeyCode, ~] = KbCheck(6);

    x = [];

    while numel(x) == 0

        [~, secs, keyCode, ~] = KbCheck(6);

        x = find(keyCode > oldkeyCode);

        oldkeyCode = keyCode;

        if secs - oldsecs > limit

            key = 0;

            return

        end

    end

    key = x(1);

end