Name: get_version_test
Release: alt1
Version: 0
Source: ftp://etersoft.ru/pub/Etersoft/TEST/%name-%version.tar.bz2
Summary: Test
Group: Other
License: Public License
%define major 1.0
%define ver 10
%define maj 1.0

%build
pushd txt
echo {1,2}text
%__subst "s|1|2|g" text/{1,eweew}
%__subst "s|1re er| erer2|g" text/{1,eweew} nono
mkdir ${LOCATION}/{loc1,dedt,ohi}
mkdir $LOCATION/{loc1,dedt,ohi}
mkdir LOCATION/{loc1,dedt,ohi}
popd

chmod a+x %buildroot%_datadir/%name/{serv-,epm-}*

%description
Get version test
%changelog
* Date
- Hello
  * dsdkljd
* Date

