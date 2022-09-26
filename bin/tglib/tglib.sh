#!/bin/bash

sdir=$(dirname ${BASH_SOURCE[0]})

source $sdir/.personal.sh

_apicall() {
    read token <$sdir/.token

    curl --silent \
        -X POST $TGAPI/bot$token/$1 \
        "${@:2}"
}

apicall() {
    #_apicall "$@"
    #_apicall "$@" | tee -a apicall.log
    _apicall "$@" | tee -a apicall.log | jq
}

sendAudio() {
    apicall \
        sendAudio \
        -F chat_id="$1" \
        -F caption="${@:3}" \
        -F audio=@"$2"
}

sendMessage() {
    apicall \
        sendMessage \
        -F parse_mode=MarkdownV2 \
        -F chat_id="$1" \
        -F text="${@:2}"
}

sendPhoto() {
    apicall \
        sendPhoto \
        -F chat_id="$1" \
        -F caption="${@:3}" \
        -F photo=@"$2"
}


sendVideo() {
    apicall \
        sendVideo \
        -F chat_id="$1" \
        -F caption="${@:3}" \
        -F video=@"$2"
}

sendDocument() {
    apicall \
        sendDocument \
        -F chat_id="$1" \
        -F document=@"$2"
}

function tgmono {
    echo -e "\x60${@}\x60"
}

function tglog {
    m=$(tgmono "${@:2}")
    sendMessage $1 "$m"
}

