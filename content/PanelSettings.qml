//=================================================================================================
/*
    Copyright (C) 2015-2020 MotionBox authors united with omega. <http://omega.gg/about>

    Author: Benjamin Arnaud. <http://bunjee.me> <bunjee@omega.gg>

    This file is part of MotionBox.

    - GNU General Public License Usage:
    This file may be used under the terms of the GNU General Public License version 3 as published
    by the Free Software Foundation and appearing in the LICENSE.md file included in the packaging
    of this file. Please review the following information to ensure the GNU General Public License
    requirements will be met: https://www.gnu.org/licenses/gpl.html.
*/
//=================================================================================================

import QtQuick 1.0
import Sky     1.0

Panel
{
    id: panelSettings

    //---------------------------------------------------------------------------------------------
    // Properties
    //---------------------------------------------------------------------------------------------

    /* read */ property bool isExposed: false

    /* read */ property int indexCurrent: -1

    //---------------------------------------------------------------------------------------------
    // Private

    property bool pAnimate: false

    //---------------------------------------------------------------------------------------------
    // Aliases
    //---------------------------------------------------------------------------------------------

    property alias page: loader.item

    //---------------------------------------------------------------------------------------------
    // Settings
    //---------------------------------------------------------------------------------------------

//#QT_4
    anchors.right: parent.right
    anchors.top  : parent.bottom

    anchors.rightMargin: st.dp96
//#ELSE
    // FIXME Qt5.12 Win8: Panel size changes for no reason when hidden.
    x: parent.width - width - st.dp96

    y: parent.height + height
//#END

    width: st.dp400 + borderSizeWidth

    height: bar.height + loader.height + borderSizeHeight

    borderRight : borderSize
    borderBottom: 0

    visible: false

    backgroundOpacity: st.panelContextual_backgroundOpacity

    //---------------------------------------------------------------------------------------------
    // States
    //---------------------------------------------------------------------------------------------

    states: State
    {
        name: "visible"; when: isExposed

//#QT_4
        AnchorChanges
        {
            target: panelSettings

            anchors.top   : undefined
            anchors.bottom: parent.bottom
        }
//#ELSE
        PropertyChanges
        {
            target: panelSettings

            y: parent.height - panelSettings.height
        }
//#END
    }

    transitions: Transition
    {
        SequentialAnimation
        {
//#QT_4
            AnchorAnimation
            {
                duration: st.duration_faster

                easing.type: st.easing
            }
//#ELSE
            NumberAnimation
            {
                property: "y"

                duration: st.duration_faster

                easing.type: st.easing
            }
//#END

            ScriptAction
            {
                script:
                {
                    if (isExposed == false) visible = false;

                    z = 0;
                }
            }
        }
    }

    //---------------------------------------------------------------------------------------------
    // Keys
    //---------------------------------------------------------------------------------------------

    Keys.onPressed:
    {
        if (event.key == Qt.Key_Escape)
        {
            event.accepted = true;

            collapse();
        }
    }

    //---------------------------------------------------------------------------------------------
    // Animations
    //---------------------------------------------------------------------------------------------

    Behavior on height
    {
        enabled: pAnimate

        PropertyAnimation
        {
            duration: st.duration_fast

            easing.type: st.easing
        }
    }

    //---------------------------------------------------------------------------------------------
    // Functions
    //---------------------------------------------------------------------------------------------

    function expose()
    {
        if (isExposed || actionCue.tryPush(gui.actionSettingsExpose)) return;

        gui.panelAddHide();

        panelGet.collapse();

        if (indexCurrent == -1)
        {
            indexCurrent = 0;

            loader.load(Qt.resolvedUrl("PageSettingsVideo.qml"));

            //page.onShow();
        }
        /*else if (indexCurrent == 0)
        {
            page.onShow();
        }*/

        isExposed = true;

        z = 1;

        panelGet.z = 0;

        visible = true;

        gui.startActionCue(st.duration_faster);
    }

    function collapse()
    {
        if (isExposed == false || actionCue.tryPush(gui.actionSettingsCollapse)) return;

        isExposed = false;

        gui.startActionCue(st.duration_faster);
    }

    function toggleExpose()
    {
        if (isExposed) collapse();
        else           expose  ();
    }

    //---------------------------------------------------------------------------------------------
    // Private

    function pSelectTab(index)
    {
        if (loader.isAnimated || indexCurrent == index) return;

        indexCurrent = index;

        pAnimate = true;

        if (indexCurrent == 0)
        {
             loader.loadRight(Qt.resolvedUrl("PageSettingsVideo.qml"));
        }
        else loader.loadLeft(Qt.resolvedUrl("PageConsole.qml"));

        pAnimate = false;

        loader.item.forceActiveFocus();
    }

    //---------------------------------------------------------------------------------------------
    // Childs
    //---------------------------------------------------------------------------------------------

    BarTitle
    {
        id: bar

        anchors.left : parent.left
        anchors.right: parent.right

        height: st.dp32 + borderSizeHeight

        borderTop: 0

        ButtonPiano
        {
            id: buttonVideo

            width: st.dp128

            checkable: true
            checked  : (indexCurrent == 0)

            checkHover: false

            text: qsTr("Video")

            font.pixelSize: st.dp14

//#QT_4
            onPressed: pSelectTab(0)
//#ELSE
            onPressed: Qt.callLater(pSelectTab, 0)
//#END
        }

        ButtonPiano
        {
            anchors.left: buttonVideo.right

            width: st.dp128

            checkable: true
            checked  : (indexCurrent == 1)

            checkHover: false

            text: qsTr("Console")

            font.pixelSize: st.dp14

//#QT_4
            onPressed: pSelectTab(1)
//#ELSE
            onPressed: Qt.callLater(pSelectTab, 1)
//#END
        }
    }

    LoaderSlide
    {
        id: loader

        anchors.left : parent.left
        anchors.right: parent.right
        anchors.top  : bar.bottom

        height: (item) ? item.height : 0
    }
}
