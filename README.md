# CustomImageTitleButton

自定义UIButton中图片(ImageView)和标题(Title)的位置, 默认为左边图片右边文字. 支持其他三种图片标题的位置, 分别为左边文字右边图片, 上边文字下边图片, 上边图片下边文字. 支持xib/代码创建, 需要在创建之后调用

`func resetEdgeInsets(type: imageTitleType, space: CGFloat = 0.0)`

来修改图片标题显示样式