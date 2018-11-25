<template>
  <transition name="slide-down">	
		<div class="title-wrap" v-show="ifTitleAndMenuShow">
			<div class="left">
				<span class="iconfont icon-fanhui"></span>
			</div>
			<div class="right">
				<div class="icon-wrap">
					<span class="iconfont icon-gouwuche"></span>
				</div>
				<div class="icon-wrap">
					<span class="iconfont icon-touxiang"></span>
				</div>
				<div class="icon-wrap">
					<span class="iconfont icon-gengduo"></span>
				</div>
			</div>
		</div>
	</transition>
</template>

<script>
export default {
  name: 'TitleBar',
  props:{
  	ifTitleAndMenuShow: {
  		type: Boolean,
  		default: false
  	}
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
$fontSize: 37.5;
@function px2rem($px){
	@return ($px / $fontSize) + rem;
}
@mixin center {
	display: flex;
	justify-content: center;
	align-items: center;
}
.title-wrap {
	position: absolute;
	top: 0;
	left: 0;
	z-index: 101;
	width: 100%;
	height: px2rem(48);
	background: #fff;
	display: flex;
	box-shadow: 0 px2rem(8) px2rem(8) rgba(0,0,0,.15);
	.left {
		flex: 0 0 px2rem(40);
		@include center;
	}
	.right {
		flex: 1;
		display: flex;
		justify-content: flex-end;
		.icon-wrap {
			flex: 0 0 px2rem(40);
			@include center;
		}
	}
}
</style>
