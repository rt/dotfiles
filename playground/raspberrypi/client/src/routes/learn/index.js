import React from 'react';
import Layout from '../../components/apps/learn/Layout';
import Learn from '../../components/apps/learn/Learn';
import AboutRpi from '../../components/apps/learn/rpi/AboutRpi';
import Environment from '../../components/apps/learn/rpi/Environment';
import PythonPrimer from '../../components/apps/learn/rpi/PythonPrimer';
import BlinkingLED from '../../components/apps/learn/rpi/BlinkingLED';
import BasicCircuit from '../../components/apps/learn/rpi/BasicCircuit';
import PullUpDownResistor from '../../components/apps/learn/rpi/PullUpDownResistor';
import PushButtonLED from '../../components/apps/learn/rpi/PushButtonLED';
import PwmLED from '../../components/apps/learn/rpi/PwmLED';
import FlowingLEDs from '../../components/apps/learn/rpi/FlowingLEDs';
import RgbLED from '../../components/apps/learn/rpi/RgbLED';
import ShiftRegister from '../../components/apps/learn/rpi/ShiftRegister';
import SevenSegment from '../../components/apps/learn/rpi/SevenSegment';
import Accelerometer from '../../components/apps/learn/rpi/Accelerometer';
import RotaryEncoder from '../../components/apps/learn/rpi/RotaryEncoder';
import WebServer from '../../components/apps/learn/rpi/WebServer';
import WebSockets from '../../components/apps/learn/rpi/WebSockets';
import JanKenPo from '../../components/apps/learn/rpi/JanKenPo';
import AboutMisc from '../../components/apps/learn/misc/AboutMisc';
import Nano from '../../components/apps/learn/misc/Nano';
import BasicLinux from '../../components/apps/learn/misc/BasicLinux';
import PythonReference from '../../components/apps/learn/misc/PythonReference';
import { stores} from '../../libs/home';

const getStore = stores.dataStore.getStore;

export default {

    path: '/learn',

    children: [
        {
            path: '/',
            async action(context) {
                //await setReferenceRoute();
                return {
                    title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                    component: <Layout><Learn /></Layout>,
                };
            },
        },
        {
            path: '/rpi',
            children: [
                {
                    path: '/',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><AboutRpi /></Layout>
                        };
                    },
                },
                {
                    path: '/environment',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><Environment /></Layout>
                        };
                    },
                },
                {
                    path: '/python-primer',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><PythonPrimer /></Layout>
                        };
                    },
                },
                {
                    path: '/blinking-led',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><BlinkingLED /></Layout>
                        };
                    },
                },
                {
                    path: '/basic-circuit',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><BasicCircuit /></Layout>
                        };
                    },
                },
                {
                    path: '/pull-up-down-resistor',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><PullUpDownResistor /></Layout>
                        };
                    },
                },
                {
                    path: '/push-button-led',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><PushButtonLED /></Layout>
                        };
                    },
                },
                {
                    path: '/flowing-leds',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><FlowingLEDs /></Layout>
                        };
                    },
                },
                {
                    path: '/pwm-led',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><PwmLED /></Layout>
                        };
                    },
                },
                {
                    path: '/shift-register',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><ShiftRegister /></Layout>
                        };
                    },
                },
                {
                    path: '/seven-segment',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><SevenSegment /></Layout>
                        };
                    },
                },
                {
                    path: '/webserver',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><WebServer /></Layout>
                        };
                    },
                },
                {
                    path: '/websockets',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><WebSockets /></Layout>
                        };
                    },
                },
                {
                    path: '/rgb-led',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><RgbLED /></Layout>
                        };
                    },
                },
                {
                    path: '/accelerometer',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><Accelerometer /></Layout>
                        };
                    },
                },
                {
                    path: '/rotary-encoder',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><RotaryEncoder /></Layout>
                        };
                    },
                },
                {
                    path: '/jan-ken-po',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><JanKenPo /></Layout>
                        };
                    },
                }
            ]

        },
        {
            path: '/misc',
            children: [
                {
                    path: '/',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><AboutMisc /></Layout>
                        };
                    },
                },
                {
                    path: '/nano',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><Nano /></Layout>
                        };
                    },
                },
                {
                    path: '/linux',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><BasicLinux /></Layout>
                        };
                    },
                },
                {
                    path: '/python-reference',
                    async action(context) {
                        return {
                            title: getStore().getUiData().getRouteTitle(context.baseUrl + context.path),
                            component: <Layout><PythonReference /></Layout>
                        };
                    },
                }
            ]

        },
    ]

};
