import cv2

cap = cv2.VideoCapture(0)


def searchForMovement(objectDetected, thresholdImage, cameraFeed):
    temp = thresholdImage.copyTo(temp)
    # these two vectors needed for output of findContours
    #vector<   vector<Point> > contours;
    #vector<Vec4i> heirarchy

    #findContours(temp, contours, heirarchy, CV_RET_CCOMP,CV_CHAIN_APPROX_SIMPLE) #retrieves all contours
    findContours(temp, contours, heirarchy, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_SIMPLE)

    if contours.sive() > 0:
        objectDetected = True
    else:
        objectDetected = False

    if objectDetected:
        #the largest contour is found at the end of the contours vector
        #we will simply assume that the beggest contour is the object we are looking for.
        largestContourVec.push_back(contrours.at(contours.size() - 1))
        # make a bounding rectangle aroudn the largest contour then find its centroid
        # this will be the object's final estimated position.
        objectBoundingRectangle = boundingRect(largestContourVec.at(0))
        xpos = objectBoundingRectanble.x + objectBoundingRectangle.width / 2
        ypos = objectBoundingRectanble.y + objectBoundingRectangle.width / 2

        # update the objects positions by changing the 'theObject' array values
        theObject[0] = xpos
        theObject[1] = ypos

    #make some temp x and y variables so we don't have to type out so much 
    x = theObject[0]
    y = theObject[1]

    # draw some crosshairs on the object
    circle(cameraFeed, Point(x,y), 20, Scalar(0, 255, 0), 2)
    line(cameraFeed, Point(x,y), Point(x, y - 25), Scalar(0, 255, 0), 2)
    line(cameraFeed, Point(x,y), Point(x, y + 25), Scalar(0, 255, 0), 2)
    line(cameraFeed, Point(x,y), Point(x - 25, y), Scalar(0, 255, 0), 2)
    line(cameraFeed, Point(x,y), Point(x + 25, y), Scalar(0, 255, 0), 2)
    putText(cameraFeed, "Tracking object at (" + intToSTring(x) + ", " + inttoString(y) + ")", Point(x,y), 1, 1, Scalar(255,0,0))






# our sensitivity value used in absdiff (if have noise could increses to 40+) or reverse down to 10
SENSITIVITY_VALUE = 20
BLUR_SIZE = 10

objectDetected = False
#these two can be toggled by pressing 'd' or 't'
debugMode = False
trackingEnabled = False

# the object to search for and keep track of its position
theObject[2] = {0,0}

# bounding rectangle of the object, we use the center of this as its position
Rect objectBoundingRectangle = rect(0,0,0,0)

# check if the video has reached its last frame
# we add '-1' because we are reading two frames from the video at a time
# if this is not included, we get a memory error!
# while(cap.get(CV_CAP_PROP_POS_FRAMES) < cap.get(CV_CAP_PROP_FRAME_COUNT) - 1):
while(True):
    
    #read first frame
    ret1, frame1 = cap.read()
    gray1 = cv2.cvtColor(frame1, cv2.COLOR_BGR2GRAY)

    ret2, frame2 = cap.read()
    gray2 = cv2.cvtColor(frame2, cv2.COLOR_BGR2GRAY)


    # get "intensite image" (this is not threshold)
    differenceImage = cv2.absdiff(gray1, gray2)

    # get threshold
    thresholdImage = cv2.threshold(differenceImage, SENSITIVITY_VALUE, 255, THRESH_BINARY)

    if debugMode:
        #show the difference image and threshold image
        cv2.imgshow("Difference Image", differenceImage)
        cv2.imgshow("Threshold Image", thresholdImage)
    else:
        cv2.destroyWindow("Difference Image")
        cv2.destroyWindow("Threshold Image")


    #blur the image to get rid of the noise. This will output an intensity image
    cv2.blur(thresholdImage, thresholdImage, cv2, BLUR_SIZE, BLUR_SIZE)

    # threshold again to obtain bianry image from blur output 
    thresholdImage = cv2.threshold(differenceImage, SENSITIVITY_VALUE, 255, THRESH_BINARY)

    if debugMode:
        # show the threshold image after it's been "blurred"
        cv2.imgshow("Final Threshold Image", thresholdImage)

    else:
        # destroy windows
        cv2.destroyWindow("Final Threshold Image")

    #if tracking enabled, search for contours in our thresholded image
    if trackingEnabled:
        searchForMovement(thresholdImage, frame1)


    #pause and resume code
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

    # elif cv2.waitKey(1) == 27: #'t'
        # trackingEnabled = not trakingEnabled
        # if trackingEnabled == False:
            # print("Tracking disabled")
        # else:
            # print("Tracking enabled")

    # elif cv2.waitKey(1) == 100: #'d'
        # debugMode = not debugMode
        # if debugMode == False:
            # print("Debug mode disabled")
        # else:
            # print("Debug mode enabled")

    # elif cv2.waitKey(1) == 112: #'p'
        # pause = not pause
        # if pause:
            # print("Code paused, press 'p' again to resume")
        # while pause:
            # #stay in this loop until
            # if cv2.waitKey(1) == 112:
                # pause = False
                # break
            

cap.release()
cv2.destroyAllWindows()
