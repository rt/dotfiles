# Open CV for AllBall

Things I probably need to do 

initialization

- identifying the subject (the subject will not change during the session)
- state = 0

capturing points of interest 

- identifying when subject has the ball (state = 1)
- identifying when subject releases the ball only when current state = 1 (state = 2)
- identifying when ball goes just below the rim only when current state = 2 (state = 3), take picture


reinitialize when

- ball is not tracked (out of screen, etc)
- (optional) when another person is in the screen (do you allow a passer or not)


## Development Env

The choices are below.  Probably Dev on desktop for prototyping is the best especially 
because opencv is the main thing and you can follow tutorials on different ways to capture.
In parallel, you can try get get set up on ios or android with opencv (maybe tensorflow)
becaues you'll have to do this anyhow.

1. Dev on web

- use a webcam and point it at a video, or use a video file
- you can do this now, and the dev experience wouldn't be bad
- this would be in javascript and it might be harder to find examples
-

2. Dev on desktop

- use python scripts (a little learning curve to get the tools)
- lots of examples

3. Dev on android or ios

- use the actual camera on the mobile device (point it at a video)
- once done to an extent, you can actually take it to the park and try
- pretty good learning curve and dev cycle could be painful



## Program

state = 0

onTap
  
  if state = 0 or state = 1:
    changeSubject(x,y)

init
  state = captureSubject()  


onReady // only if state = 1

  loop

    if state = 1
      if hasBallAndReadyToShoot()
        state = 2
    elif state = 2 and releaseBall()
        state = 3
    elif state 3 and goodForPicture()
        takePictureAndDetermine
        state = 1
    elif hasBallAndReadyToShoot()
      state = 1
      
        
 



