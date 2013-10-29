%ifdef __GIT_COMMIT__
%define ver __GIT_COMMIT__
%else
%define ver "unknown"
%endif

@SETD 0x0045576B str_fmt_ver
@SETW 0x005F56DC 0

[org 0x005F56DE]
str_fmt_ver:
    db "UOSA %s+", ver, 0
