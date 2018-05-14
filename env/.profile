if [[ $HOST == 'GOT120FRM0YF2' ]]
then
    #export http_proxy="http://gotpr002vip.got.volvocars.net:83"
    #export https_proxy="https://gotpr002vip.got.volvocars.net:83"
    #export no_proxy="*.volvocars.net"
    xinput --disable 13
fi

ccache -M 50GB

#wal -R -t

#xinput --disable 11

export PATH=$PATH:~/Apps/pycharm-community-2017.3.2/bin
