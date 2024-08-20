# Robot-Control-VirtualProtoType-Simulation
This repository mainly comprises various types of robot mechanical configuration designs, kinematic and dynamic modeling, relevant controller designs and their parameter tuning, optimal control algorithm designs, as well as debugging of physical prototypes.  Further content will be continuously added.  
此存储库主要包括各种类型的机器人机械配置设计、运动学和动力学建模、相关控制器设计及其参数调整、最优控制算法设计以及物理原型调试。未来还将持续添加更多内容。  
## ADRC_4ODF_CDPR
   The cable-suspended parallel robot is a new type of parallel mechanism that uses cables instead of rigid links to connect the moving and static platforms. Compared with traditional parallel robots, it has the advantages of fast moving speed and large working space. At the same time, due to its simple structure and wide range of applications, it is widely used in fields such as processing and assembly, wind tunnel experiments, medical rehabilitation, etc.   
悬索并联机器人是一种以悬索替代刚性连杆连接动、静平台的新型并联机构。相较于传统构型的并联机器人，它具有移动速度快、工作空间大等优点。同时因其具有结构简单、适用范围广的优点，它被广泛应用于加工装配、风洞实验、医疗康复等领域。  
This work selects a four-degree-of-freedom (DOF) parallel robot with translational freedoms in the x, y, and z directions and a rotational freedom in the z direction, driven by four motors connected to four sets of parallel suspension cables, as the subject for dynamic modeling verification and control algorithm design. The specific contents are as follows: A dynamic model is established for the four-DOF parallel robot with parallel cable groups using the Lagrange method. Polynomial planning is employed to generate point-to-point, circular, and gate-shaped trajectories, and a virtual prototype of the cable-suspended parallel robot is constructed to verify the validity of the dynamic model. An active disturbance rejection controller based on the dynamic model is designed to enable the robot to move along preset desired trajectories.  
内容选取具有x,y,z三方向平动自由度以及z向转动自由度，并以四个电机驱动四组平行悬索的四自由度并联机器人为对象，进行了动力学建模验证和控制算法的设计。具体内容如下：以含平行索组的四自由度并联机器人为对象，通过拉格朗日法建立其动力学模型。采用多项式规划点对点轨迹、圆周轨迹和门字形轨迹，搭建了该悬索并联机器人的虚拟样机，验证了动力学模型的有效性；设计了基于动力学模型的自抗扰控制器，使机器人能够沿着预设的期望轨迹进行运动。   
The simulation results show that the virtual prototype designed and built in this paper can reflect the dynamic characteristics of the cable-suspended parallel robot relatively accurately, and the control algorithm adopted can achieve good trajectory tracking control while maintaining good stability.  
    仿真实验结果表明，本文设计搭建的虚拟样机能够较为准确地反映该悬索并联机器人的动力学特性，采用的控制算法能够较好地实现轨迹追踪控制，同时能够保持较好的稳定性。  

   The procdures of VritualType design are as follows:  
   悬索机器人的设计虚拟样机设计文档如下所示：    
https://github.com/IceRain-y/Robot-Control-VirtualProtoType/blob/main/ADRC_Control_4DOF_CDPR/%E8%99%9A%E6%8B%9F%E6%A0%B7%E6%9C%BA%E6%8A%80%E6%9C%AF%E6%89%8B%E5%86%8C.docx
