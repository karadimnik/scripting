## Setup 'auto' port forwarding to wsl2

The following method covers the need to maintain outside communication with wsl2 running apps, even after Windows(Host) machine restart.

  

#### Limitation(Problem):

- Windows (Host) manages the networks for wsl2 running OS(Guest)
- Upon Host restart, network addresses are changed for the wsl2 OS(Guest)
- Host to Guest communication is maintained through 'localhost' but it's lost for 3rd parties, trying to access Guest through Host via IP(i.e. 192.168.1.3:8081)

  

#### Solution:
*The following are compiled by already established solutions on the web.*

 1. Download `windows-scripts` folder.
 2. Create Simple task using Windows' "Task Scheduler".
    - As Action, select "Start a program" and then locate one of the `*.cmd` files provided by this repo.
    - Set a delay of 30 seconds, to assure wsl2 startup.
    - Check -> Run with highest privileges
    - Check -> Run only when user is logged on ( Not tested otherwise )
    - OK and Restart
3. After the restart, check `.log`and `.txt` files for more info