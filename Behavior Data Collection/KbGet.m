function [secs,key] = KbGet(limit, varargin)

%[secs key] = KbGet([limit])

%?��??�?�?????�?并�???�??��?�??????��???��??

%??以�?�置limit?��???��??????�??��?��?�??��??�???key = 0

%精度�?KbStrokeWait�?

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