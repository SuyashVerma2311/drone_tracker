#!/usr/bin/env python3

import rospy
from std_msgs.msg import Int32
import random

def talker():
    pub = rospy.Publisher('/temp_sub', Int32, queue_size=10)
    rospy.init_node('talker', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        out = random.randint(1,50)
        print(f"I just published {out}")
        pub.publish(out)
        rate.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
