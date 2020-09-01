function [y] = cut(x,t,Fs)
%cut cut vector
%   cut(x,t,Fs) returns the
%
%   Authors: Lucas Abdalah       (lucasabdalah@gmail.com)
%
% Version History:
% - AAAA/MM/DD
%

% x = x;

%% More leads than samples
leads = min(size(x)); % Takes the number of leads/channels
N = max(size(x)); % Takes the number of leads/channels

if t(1) == 0
  sampleCut = t.*Fs;
  sampleCut(1) = 1;
  for ii = 1:leads
    y(ii,:) = x(ii, ceil(sampleCut(1)):ceil(sampleCut(2)));
  end
else
  sampleCut = t.*Fs;
  for ii = 1:leads
    y(ii,:) = x(ii, floor(sampleCut(1)):floor(sampleCut(2)));
  end
end


end

% duration = 300 % ms - unity
% n=numel(s);
% n1=fix(n*time(1)/duration);
% n2=fix(n*time(2)/duration);
% out=s(n1:n2)
