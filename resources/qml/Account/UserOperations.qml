// Copyright (c) 2022 UltiMaker
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.10
import QtQuick.Controls 2.3

import UM 1.5 as UM
import Cura 1.1 as Cura

Column
{
    spacing: UM.Theme.getSize("default_margin").height
    topPadding: UM.Theme.getSize("default_margin").height
    bottomPadding: UM.Theme.getSize("default_margin").height
    width: childrenRect.width

    Item
    {
        id: accountInfo
        width: childrenRect.width
        height: accountSyncDetailsColumn.height
        anchors.left: parent.left
        anchors.leftMargin: UM.Theme.getSize("default_margin").width
        AvatarImage
        {
            id: avatar
            anchors.verticalCenter: parent.verticalCenter

            width: UM.Theme.getSize("main_window_header").height
            height: UM.Theme.getSize("main_window_header").height

            source: profile["profile_image_url"] ? profile["profile_image_url"] : ""
            maskColor: UM.Theme.getColor("main_background")
            outlineColor: UM.Theme.getColor("main_background")
        }
        Rectangle
        {
            id: initialCircle
            width: avatar.width
            height: avatar.height
            radius: width
            anchors.verticalCenter: parent.verticalCenter
            color: UM.Theme.getColor("action_button_disabled")
            visible: !avatar.hasAvatar
            UM.Label
            {
                id: initialLabel
                anchors.centerIn: parent
                text: profile.username.charAt(0).toUpperCase()
                font: UM.Theme.getFont("large_bold")
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Column
        {
            id: accountSyncDetailsColumn
            anchors.left: avatar.right
            anchors.leftMargin: UM.Theme.getSize("default_margin").width
            spacing: UM.Theme.getSize("narrow_margin").height
            width: childrenRect.width
            height: childrenRect.height

            UM.Label
            {
                id: username
                text: profile.username
                font: UM.Theme.getFont("large_bold")
            }

            SyncState
            {
                id: syncRow
            }
            UM.Label
            {
                id: lastSyncLabel
                text: catalog.i18nc("@label The argument is a timestamp", "Last update: %1").arg(Cura.API.account.lastSyncDateTime)
                color: UM.Theme.getColor("text_medium")
            }
        }
    }

    Rectangle
    {
        width: parent.width
        color: UM.Theme.getColor("lining")
        height: UM.Theme.getSize("default_lining").height
    }
    Cura.TertiaryButton
    {
        id: cloudButton
        width: parent.width
        height: UM.Theme.getSize("account_button").height

        text: "UltiMaker Digital Factory"
        onClicked: Qt.openUrlExternally(CuraApplication.ultimakerDigitalFactoryUrl + "?utm_source=cura&utm_medium=software&utm_campaign=menu-visit-DF")
        fixedWidthMode: false
    }

    Cura.TertiaryButton
    {
        id: accountButton
        width: parent.width
        height: UM.Theme.getSize("account_button").height

        text: catalog.i18nc("@button", "UltiMaker Account")
        onClicked: Qt.openUrlExternally(CuraApplication.ultimakerCloudAccountRootUrl + "?utm_source=cura&utm_medium=software&utm_campaign=menu-visit-account")
        fixedWidthMode: false
    }

    Rectangle
    {
        width: parent.width
        color: UM.Theme.getColor("lining")
        height: UM.Theme.getSize("default_lining").height
    }

    Cura.TertiaryButton
    {
        id: signOutButton
        width: parent.width
        height: UM.Theme.getSize("account_button").height

        onClicked: Cura.API.account.logout()
        text: catalog.i18nc("@button", "Sign Out")
        fixedWidthMode: false
    }
}
