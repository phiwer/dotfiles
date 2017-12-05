if [[ $HOST == 'GOT120FRM0YF2' ]]
then
    export http_proxy="http://gotpr002vip.got.volvocars.net:83"
    export https_proxy="https://gotpr002vip.got.volvocars.net:83"
    export no_proxy="*.volvocars.net"
fi

ccache -M 50GB
