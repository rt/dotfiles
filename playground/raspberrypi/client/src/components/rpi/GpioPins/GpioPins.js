import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './GpioPins.css';
import Base from '../../../../Base';
import NavList from '../../../../NavList';

class GpioPins extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div className={s.root}>
                <table className={s.gpioPins}>
                    <tbody><tr>
                      <td style={{width:'40%'}} className={s.power}>3V3</td>
                      <td style={{width:'10%'}}>1</td>
                      <td style={{width:'10%'}}>2</td>
                      <td style={{width:'40%'}} className={s.power}>5V</td>
                    </tr>
                    <tr>
                      <td className={s.i2c}>GPIO 2</td>
                      <td>3</td>
                      <td>4</td>
                      <td className={s.power}>5V</td>
                    </tr>
                    <tr>
                      <td className={s.i2c}>GPIO 3</td>
                      <td>5</td>
                      <td>6</td>
                      <td className={s.ground}>GND</td>
                    </tr>
                    <tr>
                      <td className={s.gpio}>GPIO 4</td>
                      <td>7</td>
                      <td>8</td>
                      <td className={s.uart}>GPIO 14</td>
                    </tr>
                    <tr>
                      <td className={s.ground}>GND</td>
                      <td>9</td>
                      <td>10</td>
                      <td className={s.uart}>GPIO 15</td>
                    </tr>
                    <tr>
                      <td className={s.gpio}>GPIO 17</td>
                      <td>11</td>
                      <td>12</td>
                      <td className={s.gpio}>GPIO 18</td>
                    </tr>
                    <tr>
                      <td className={s.gpio}>GPIO 27</td>
                      <td>13</td>
                      <td>14</td>
                      <td className={s.ground}>GND</td>
                    </tr>
                    <tr>
                      <td className={s.gpio}>GPIO 22</td>
                      <td>15</td>
                      <td>16</td>
                      <td className={s.gpio}>GPIO 23</td>
                    </tr>
                    <tr>
                      <td className={s.power}>3V3</td>
                      <td>17</td>
                      <td>18</td>
                      <td className={s.gpio}>GPIO 24</td>
                    </tr>
                    <tr>
                      <td className={s.spi}>GPIO 10</td>
                      <td>19</td>
                      <td>20</td>
                      <td className={s.ground}>GND</td>
                    </tr>
                    <tr>
                      <td className={s.spi}>GPIO 9</td>
                      <td>21</td>
                      <td>22</td>
                      <td className={s.gpio}>GPIO 25</td>
                    </tr>
                    <tr>
                      <td className={s.spi}>GPIO 11</td>
                      <td>23</td>
                      <td>24</td>
                      <td className={s.spi}>GPIO 8</td>
                    </tr>
                    <tr>
                      <td className={s.ground}>GND</td>
                      <td>25</td>
                      <td>26</td>
                      <td className={s.spi}>GPIO 7</td>
                    </tr>
                    <tr>
                      <td className={s.dnc}>DNC</td>
                      <td>27</td>
                      <td>28</td>
                      <td className={s.dnc}>DNC</td>
                    </tr>
                    <tr>
                      <td className={s.gpio}>GPIO 5</td>
                      <td>29</td>
                      <td>30</td>
                      <td className={s.ground}>GND</td>
                    </tr>
                    <tr>
                      <td className={s.gpio}>GPIO 6</td>
                      <td>31</td>
                      <td>32</td>
                      <td className={s.gpio}>GPIO 12</td>
                    </tr>
                    <tr>
                      <td className={s.gpio}>GPIO 13</td>
                      <td>33</td>
                      <td>34</td>
                      <td className={s.ground}>GND</td>
                    </tr>
                    <tr>
                      <td className={s.gpio}>GPIO 19</td>
                      <td>35</td>
                      <td>36</td>
                      <td className={s.gpio}>GPIO 16</td>
                    </tr>
                    <tr>
                      <td className={s.gpio}>GPIO 26</td>
                      <td>37</td>
                      <td>38</td>
                      <td className={s.gpio}>GPIO 20</td>
                    </tr>
                    <tr>
                      <td className={s.ground}>GND</td>
                      <td>39</td>
                      <td>40</td>
                      <td className={s.gpio}>GPIO 21</td>
                    </tr>
                  </tbody>
                </table>
                <table>
                    <tbody><tr><td>Physical Pin Number</td></tr>
                    <tr><td className={s.power}>Power +</td></tr>
                    <tr><td className={s.ground}>Ground</td></tr>
                    <tr><td className={s.uart}>UART</td></tr>
                    <tr><td className={s.i2c}>I2C</td></tr>
                    <tr><td className={s.spi}>SPI</td></tr>
                    <tr><td className={s.gpio}>GPIO</td></tr>
                    <tr><td className={s.dnc}>Do Not Connect</td></tr>  
                  </tbody>
                </table>
            </div>
        );
    }
}

export default withStyles(s)(GpioPins);
