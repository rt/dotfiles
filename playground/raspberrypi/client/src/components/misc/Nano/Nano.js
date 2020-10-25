import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './Nano.css';
import Base from '../../../../Base';
import BlockQuote from '../../../../BlockQuote';
import Code from '../../../../Code';
import Section from '../../Section';

class Nano extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>
                <Section title="Basics">
                    <p>
                
                Creating and editing files are the most common task you will need
                in development.  On Linux systems you can find several editor such
                as nano, vi, and emacs.  nano is probably the easiest to learn and
                that is what we'll will use but you are highly encouraged to check
                out vi and emacs (much more powerful but with a steeper learning
                    curve).  
                
                While this might seem cumbersome at first, it will be your primary
                tool for editing files.  The great thing about these editors is
                that they are usually available so you can immediately access a
                system and start hacking away!

                    </p>

                    Let's try. Type the following into the terminal. 

                    <Code
                        text={`

        $ nano

                        `.trim()}
                    />

                    Type anything to test the waters.


                    Type <code>ctrl-x</code> to exit and nano will ask you if you want to save to a file.

                    Look at the menu at the bottom of the screen.
                    <ul>
                        <li><code>ctrl-o</code>: Write File</li>
                        <li><code>ctrl-x</code>: Exit</li>
                    </ul>

                We'll go into the others and more below.

                </Section>


                <Section title="Navigation">

                    You can use <code>Home</code>, <code>End</code>, <code>Page Up</code>, <code>Page Down</code>, and the arrow keys but that requires moving your hands from the home position.
                    When editing lots of code you'll want to have shortcuts to get things done faster.

                    <ul>
                        <li><code>ctrl-f</code>: Right or Forward</li>
                        <li><code>ctrl-b</code>: Left or Backward</li>
                        <li><code>ctrl-p</code>: Up</li>
                        <li><code>ctrl-n</code>: Down</li>
                        <li><code>ctrl-a</code>: Home</li>
                        <li><code>ctrl-e</code>: End</li>
                        <li><code>ctrl-v</code>: Page Down</li>
                        <li><code>ctrl-y</code>: Page Up</li>
                    </ul>
                    
                    There's more.

                    <ul>
                        <li><code>ctrl-space</code>: Forward one word</li>
                        <li><code>meta-space</code>: Backward one word</li>
                        <li><code>ctrl-_</code>: Go to line</li>
                    </ul>

                    
                    <BlockQuote
                        text="the Meta Key : Alt on Windows/Linux, Esc on Mac"
                    />
                    <BlockQuote
                        text="Make sure you use Alt+Cmd+O to change OSX Terminal's behaviour to treat Alt as Meta"
                    />

                    Now let's try using <code>ctrl-g</code>: <i>Help</i> because we can navigate through it.
                You can find all the details you need via <i>Help</i>.

                </Section>

                
                <Section title="Copy, Cut, and Paste">

                    In a graphical environment we highlight text to be copied with
                the cursor. In nano we <i>mark</i> it by using <code>ctrl-^</code>.
                
                    <ol>
                        <li>To cut or copy text you navigate to one end of the text, <i>mark</i> it</li>
                        <li>Navigate to other end of text</li>
                        <li>To copy hit <code>meta-^</code>, to cut hit <code>ctrl-k</code></li>
                        <li>Navigate to where you want to paste, and hit <code>ctrl-u</code></li>
                        <li>If you make a mistake along the way hit <code>ctrl-^</code> again to <i>unset the mark</i></li>
                    </ol>

                    You can also conveniently remove a line of code with <code>ctrl-k</code>.

                </Section>

                <Section title="Other Useful Shortcuts">
                
                    <ol>
                        <li><code>meta-u</code>: Undo</li>
                        <li><code>meta-e</code>: Redo</li>
                        <li><code>meta-l</code>: Toggle Line Wrap</li>
                        <li><code>ctrl-w</code>: Search, you will then see options to replace as well.</li>
                        <li><code>ctrl-t</code>: Check Spelling</li>
                    </ol>

                    When you go into different modes, usually <code>ctrl-c</code> will cancel and get you out.

                    When you really get compfortable you can also turn the
                <i>Menu</i> off with <code>meta-x</code> to get more screen space.

                </Section>

                
                <Section title=".nanorc">
                
                There <i>.nanorc</i> file in your home directory can store you preferences for nano.
                Create a <i>.nanorc</i> file.

                        <Code
                            text={`

    set autoindent
    set linenumbers
    set multibuffer
    #set nohelp
    #set titlecolor magenta

                            `.trim()}
                        />

                    See more details at <a target="_blank" href="https://www.nano-editor.org/dist/v2.5/nanorc.5.html">https://www.nano-editor.org/dist/v2.5/nanorc.5.html</a>

                </Section>


                <Section title="Editing Multiple Files">

                    <p>
                
                In order to handle multiple files at the same time in nano you
            need to <code>set multibuffer</code> in <i>.nanorc</i>.
            <code>ctrl-r esc-f</code> to open a file into a new buffer.  You
            can then move forward and backwards through the files with
            <code>meta-,</code> and <code>meta-.</code>

                    </p>

                </Section>

            </div>
        );
    }
}

export default withStyles(s)(Nano);
