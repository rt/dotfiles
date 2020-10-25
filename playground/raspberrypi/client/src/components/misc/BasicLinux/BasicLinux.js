import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './BasicLinux.css';
import Base from '../../../../Base';
import BlockQuote from '../../../../BlockQuote';
import Code from '../../../../Code';
import Link from '../../../../Link';
import Section from '../../Section';

class BasicLinux extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>

                <Section title="Purpose">

                    <p>
            The purpose of the document is to give a brief introduction to Linux primariy so
            that you can start using your Raspberry Pi in the courses.
                    </p>

            Linux is a free, open-source operating system.  It's usually at the
            core of every device we use and is the most common operating system
            of the servers that power the Internet.  This document gives the
            very basics of the terminal so that newcomers can start using
            Linux.

                </Section>


                <Section title="Terminal">
                    <p>

            Usually when you access a server you'll do so through a terminal
            shell.  The shell allows you to execute commands such as file manipulation, package
            installation, user management, and other administrative tasks.
                

                    </p>

                    Let's access our raspberry pi with a program call <code>ssh</code>.

                    <Code
                        text={`

$ ssh pi@[ hostname ].local

                        `.trim()}
                    />
            
            <i>pi</i> is the username and <i>hostname</i> is the name of your raspberry pi.


                </Section>


                <Section title="Navigation">

            The file system is a hierarchy of directories/folders and files.  
            When you log into a system you are put in <code>/home/[ username ]</code>.
            You can see your <i>current working directory</i> by typing the following.

                    <Code
                        text={`

$ pwd

                        `.trim()}
                    />

            To see other files and directories in your current working directory:

                    <Code
                        text={`

$ ls

                        `.trim()}
                    />

            There is nothing in the directory yet so lets <i>make a directory</i> called <i>test-dir</i> and <code>ls</code> again.
                    
                    <Code
                        text={`

$ mkdir test-dir
$ ls

                        `.trim()}
                    />

            We can navigate into our new directory with <code>cd</code> and <code>ls</code> again to show that there is nothing in it yet.

                    <Code
                        text={`

$ cd test-dir
$ ls

                        `.trim()}
                    />
            
            Again nothing here yet, let make another directory here.
                    
                    <Code
                        text={`

$ mkdir another-dir
$ ls

                        `.trim()}
                    />
           
            Now, lets remove the directory with <code>rmdir</code>.  Note, in order to use <code>rmdir</code> the dirctory must be empty.
                    
                    <Code
                        text={`

$ rmdir another-dir
$ ls

                        `.trim()}
                    />
            
            Let move up a directory with <code>cd ../</code>.
                    
                    <Code
                        text={`

$ cd ../
$ ls

                        `.trim()}
                    />

            <code>cd</code> can navigate you around the file system.

                    <ul>
                        <li><code>cd ../../</code>: Go the parent's parent directory</li>
                        <li><code>cd /</code>: Go to the <i>root</i> directory</li>
                        <li><code>cd ~</code>: Go back to your <i>home</i> directory</li>
                        <li><code>cd ./</code>: Go to your <i>current</i> directory (which is meaningless because you are there but worth describing the <code>./</code> path</li>)
                    </ul>

                </Section>

                
                <Section title="File Manipulation">

            Programs are made from <i>source code</i> that are just text files.  Lets work with files a bit.

            Find your way back into <i>test-dir</i> and use <code>ls</code> to show that it is empty.

            We can quickly make a file using the <code>touch</code> command.

                    <Code
                        text={`

$ touch test-file.txt
$ ls

                        `.trim()}
                    />

            You can write the contents of a file with a <i>text editor</i> such as <Link to="/learn/misc/nano">nano</Link>.

            You can remove the file with <code>rm</code>.

                    <Code
                        text={`

$ rm test-file.txt
$ ls

                        `.trim()}
                    />
            
            You can quickly display the full contents of a file with <code>cat</code>.
            When a file is large you can view page by page with <code>less</code>.
            To go to the next page by pressing <code>space</code> and exit with <code>q</code>.

                    <Code
                        text={`

$ cat ~/path/to/file
$ less ~/path/to/file

                        `.trim()}
                    />

                </Section>

                
                <Section title="man">
                
            This lesson has given you just the basic understanding of getting around on a Linux system.
            There are many commands all the details of each command can be referenced with <code>man</code>.

                    <Code
                        text={`

$ man touch

                        `.trim()}
                    />

                </Section>

- mv
- cp
- locate
- clear

- df 
- du

            </div>
        );
    }
}

export default withStyles(s)(BasicLinux);
