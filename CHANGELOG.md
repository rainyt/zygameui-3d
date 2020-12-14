### 0.0.5:
- 新增：新增`ZImage3D`对象，可以通过Frame精灵图对象，直接赋值到ZImage3D显示。

### 0.0.4:
- 新增：新增骨骼绑定`ZBindBone`支持。

### 0.0.3:
- 优化md5格式动画的加载方式：
    - 命名格式：角色名称_动作.md5anim则可以定义该角色名称的动作。
    - 角色名称.md5mesh则可以定义该角色的动作。

### 0.0.2:
- 初次版本，可配合zygameui库一起使用的3D库。
- 新增`zygame.display3d`类包，主要实现舞台的3D显示对象。
- 新增`zygame.light`类包，主要实现舞台的所有光源。
- 新增`zygamecontroller`类包，主要实现舞台的摄像头实现。
- 新增`Loader3dDData`加载类，支持加载obj/md5/dae/awd等文件。