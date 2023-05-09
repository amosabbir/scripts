freq = num2cell(Resp_pow_SE1{1}.freq');
%'
cellmat = [{'PID'} {'EO_EC'} {'Session'} {'Responder'} {'chan'} freq];

%--Resp_pow_SE1 EO----------------------------------------------

for xx = 1:7
chan = Resp_pow_SE1{xx}.label'
%'
pow = num2cell(Resp_pow_SE1{xx}.powspctrm)

Responder = repmat({'Responder'},64,1)
Session = repmat({1},64,1)
PID = repmat({xx},64,1)
EOC = repmat({'EO'},64,1)


c=[PID EOC Session Responder chan pow]

d=c(1,:)
e=c(34,:)
f=c(33,:)
g=c(5,:)
h=c(40,:)
i=c(13,:)
j=c(50,:)
k=c(21,:)
l=c(58,:)
m=c(27,:)
n=c(64,:)

c=[d;e;f;g;h;i;j;k;l;m;n]


cellmat = [cellmat;c]
end



%--Resp_pow_SE2 EO----------------------------------------------

for xx = 1:7
chan = Resp_pow_SE2{xx}.label'
%'
pow = num2cell(Resp_pow_SE2{xx}.powspctrm)

Responder = repmat({'Responder'},64,1)
Session = repmat({2},64,1)
PID = repmat({xx},64,1)
EOC = repmat({'EO'},64,1)


c=[PID EOC Session Responder chan pow]

d=c(1,:)
e=c(34,:)
f=c(33,:)
g=c(5,:)
h=c(40,:)
i=c(13,:)
j=c(50,:)
k=c(21,:)
l=c(58,:)
m=c(27,:)
n=c(64,:)

c=[d;e;f;g;h;i;j;k;l;m;n]


cellmat = [cellmat;c]
end


%--Nonresp_pow_SE1 EO----------------------------------------------

for xx = 1:12
chan = Nonresp_pow_SE1{xx}.label'
%'
pow = num2cell(Nonresp_pow_SE1{xx}.powspctrm)

Responder = repmat({'Nonresponder'},64,1)
Session = repmat({1},64,1)
PID = repmat({xx+7},64,1)
EOC = repmat({'EO'},64,1)


c=[PID EOC Session Responder chan pow]

d=c(1,:)
e=c(34,:)
f=c(33,:)
g=c(5,:)
h=c(40,:)
i=c(13,:)
j=c(50,:)
k=c(21,:)
l=c(58,:)
m=c(27,:)
n=c(64,:)

c=[d;e;f;g;h;i;j;k;l;m;n]


cellmat = [cellmat;c]
end



%--Nonresp_pow_SE2 EO----------------------------------------------

for xx = 1:12
chan = Nonresp_pow_SE2{xx}.label'
%'
pow = num2cell(Nonresp_pow_SE2{xx}.powspctrm)

Responder = repmat({'Nonresponder'},64,1)
Session = repmat({2},64,1)
PID = repmat({xx+7},64,1)
EOC = repmat({'EO'},64,1)


c=[PID EOC Session Responder chan pow]

d=c(1,:)
e=c(34,:)
f=c(33,:)
g=c(5,:)
h=c(40,:)
i=c(13,:)
j=c(50,:)
k=c(21,:)
l=c(58,:)
m=c(27,:)
n=c(64,:)

c=[d;e;f;g;h;i;j;k;l;m;n]


cellmat = [cellmat;c]
end



%--Resp_pow_SE1_EC EC----------------------------------------------

for xx = 1:7
chan = Resp_pow_SE1_EC{xx}.label'
%'
pow = num2cell(Resp_pow_SE1_EC{xx}.powspctrm)

Responder = repmat({'Responder'},64,1)
Session = repmat({1},64,1)
PID = repmat({xx},64,1)
EOC = repmat({'EC'},64,1)


c=[PID EOC Session Responder chan pow]

d=c(1,:)
e=c(34,:)
f=c(33,:)
g=c(5,:)
h=c(40,:)
i=c(13,:)
j=c(50,:)
k=c(21,:)
l=c(58,:)
m=c(27,:)
n=c(64,:)

c=[d;e;f;g;h;i;j;k;l;m;n]


cellmat = [cellmat;c]
end



%--Resp_pow_SE2_EC EC----------------------------------------------

for xx = 1:7
chan = Resp_pow_SE2_EC{xx}.label'
%'
pow = num2cell(Resp_pow_SE2_EC{xx}.powspctrm)

Responder = repmat({'Responder'},64,1)
Session = repmat({2},64,1)
PID = repmat({xx},64,1)
EOC = repmat({'EC'},64,1)


c=[PID EOC Session Responder chan pow]

d=c(1,:)
e=c(34,:)
f=c(33,:)
g=c(5,:)
h=c(40,:)
i=c(13,:)
j=c(50,:)
k=c(21,:)
l=c(58,:)
m=c(27,:)
n=c(64,:)

c=[d;e;f;g;h;i;j;k;l;m;n]


cellmat = [cellmat;c]
end


%--Nonresp_pow_SE1_EC EC----------------------------------------------

for xx = 1:12
chan = Nonresp_pow_SE1_EC{xx}.label'
%'
pow = num2cell(Nonresp_pow_SE1_EC{xx}.powspctrm)

Responder = repmat({'Nonresponder'},64,1)
Session = repmat({1},64,1)
PID = repmat({xx+7},64,1)
EOC = repmat({'EC'},64,1)


c=[PID EOC Session Responder chan pow]

d=c(1,:)
e=c(34,:)
f=c(33,:)
g=c(5,:)
h=c(40,:)
i=c(13,:)
j=c(50,:)
k=c(21,:)
l=c(58,:)
m=c(27,:)
n=c(64,:)

c=[d;e;f;g;h;i;j;k;l;m;n]


cellmat = [cellmat;c]
end



%--Nonresp_pow_SE2_EC EC----------------------------------------------

for xx = 1:12
chan = Nonresp_pow_SE2_EC{xx}.label'
%'
pow = num2cell(Nonresp_pow_SE2_EC{xx}.powspctrm)

Responder = repmat({'Nonresponder'},64,1)
Session = repmat({2},64,1)
PID = repmat({xx+7},64,1)
EOC = repmat({'EC'},64,1)


c=[PID EOC Session Responder chan pow]

d=c(1,:)
e=c(34,:)
f=c(33,:)
g=c(5,:)
h=c(40,:)
i=c(13,:)
j=c(50,:)
k=c(21,:)
l=c(58,:)
m=c(27,:)
n=c(64,:)

c=[d;e;f;g;h;i;j;k;l;m;n]


cellmat = [cellmat;c]
end


writecell(cellmat,'Power_CANBIND.xlsx')
