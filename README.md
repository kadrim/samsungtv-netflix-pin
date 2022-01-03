# samsungtv-netflix-pin

> WARNING! Do this at your own risk. Do not use these programs for malicious purposes, but for educational goals on accounts you have access to.

Just a quick bunch of files i used to test how quickly a PIN from Netflix can be aquired using the Netflix-App
on a standard E/F/H - Series Television.

## Motivation
The Netflix App does currently not rate-limit the retries upon entering a wrong parental-pin, so as an educational project
i developed a simple remote using an arduino which can be controlled via a PC. Maybe someone finds parts of this project useful for a very different
application.

## Arduino Remote

First off, you have to build a remote. This is not very complicated, you just need these components:

- current [Arduino IDE](https://www.arduino.cc/en/software) with the Library [IRremote](https://github.com/Arduino-IRremote/Arduino-IRremote) - can be typically installed via Library Manager
- almost any Arduino with an USB-Port will do, i used an Arduino Micro
- an IR-Diode, i bought a 5mm 940nm Diode from ebay (for less than a Buck), if you have an old remote, you can also use that
- A Resistor, so the Diode does not draw too much Ampere from the Arduino Pin. You check the schematics, but typically, something beetween 50-150 Ohms will do
- optionally a breadboard, so you can quickly assemble the remote.

### Assembly

1. Connect the `Resistor` to Pin `3` (sometimes called `D3`) on your `Arduino`
2. Connect the anode (long leg) of the `Diode` to the other end of the `Resistor`
3. Connect the catode (short leg) of the `Diode` to any `GND` Pin of your `Arduino`

### Testing

1. Turn on your TV
2. Connect your `Arduino` to your `PC` and upload `SamsungTVPin.ino` via the `Arduino IDE` to your `Arduino`
3. Point your assembly towards the TV, as close as possbile as the range can be limited
4. Open the `Serial Monitor` and set it to `9600 Baud`
5. Send the command `1` via the `Serial Monitor`, the Volume of the TV should increase

Congratulations, you have a working Remote which is controllable via your PC!

## PC-Controller

Needed components:

- current [Processing IDE](https://processing.org/download) with the Libraries [Serial](https://processing.org/reference/libraries/serial/index.html) and [Video](https://processing.org/reference/libraries/video/index.html) - can be typically installed via Library Manager
- a Webcam, ideally with a long cable

## Setup

1. Turn on your TV
2. Start the Netflix-App and select a Profile
3. Select a movie where the Pin is requested
4. Point your selfmade-remote towards the TV, as close as possible
5. Connect your Arduino to your PC
6. Connect your Webcam to your PC and point it towards the TV
7. Run either `ProcessingNetflixPINDate.pde` (for quickly going through Pins with the format `DDYY`) or `ProcessingNetflixPIN.pde` (for full bruteforce)

The Processing-Apps will try each available combination and save a picture taken from the webcam. The filename will always include the corresponding Pin that was used
for that try. That way you can let the program do its job and later on check on the pictures which Pin was successful.

Want to improve on that? Just go ahead and implement something like an automatic detection via webcam if the Pin was correct and stop the program :-)

## Adding more Remote-Commands

Currently there are only a few commands available:

- POWER
- INFO
- FACTORY
- THREESPEED
- VOLUP
- VOLDOWN
- ENTER
- CURSORUP
- CURSORDOWN
- CURSORRIGHT
- CURSORLEFT 

Most probably, there is a very easy way to add more commands, or they might be already available in the `IRRemote` Lib, i never checked.
Or you can record the code you are looking for with an IR-Receiver, with the same tools you used above. It is up to you.

This is how i did it:

- Search around the Web for something like `Samsung TV hex codes`
- You will surely find some page or file with a list of Hex Codes for the function you are trying to implement
- You need only a part of each hex-code
- First remove the lead-in which should be `0000 006D 0000 0022 00AC 00AB`
- Then remove the lead-out which should be `0015 0689`
- Now replace every `0015 0041` with a `1`
- Then replace every `0015 0016` with a `0`
- If needed, remove all spaces and use a hex-converter on the ones and zeros

Voilà, you have your code for the remote. Prepend a simple `0x` and use it in the arduino sketch.


## Donation
I developed this package in my free time. If you like it and want to support future updates, feel free to donate here:

[Donate via PayPal](https://www.paypal.com/donate?hosted_button_id=RDJ8ZWG3GRWE8)

Thanks in advance :-)

## Disclaimer
THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

