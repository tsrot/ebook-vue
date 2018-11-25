<template>
  <div class="menu-bar">
  	<transition name="slide-up">
		<div class="menu-wrap" 
			v-show="ifTitleAndMenuShow"
			:class="{'hode-boxshadow':isShowSetting || !ifTitleAndMenuShow}">
			<div class="icon-wrap">
				<span class="iconfont icon-mulu" @click="showContent"></span>
			</div>
			<div class="icon-wrap">
				<span class="iconfont icon-jindu" :class="{'active': showTag == 2 && isShowSetting}" @click="showSetting(2)"></span>
			</div>
			<div class="icon-wrap">
				<span class="iconfont icon-liangdu" :class="{'active': showTag == 1 && isShowSetting}" @click="showSetting(1)"></span>
			</div>
			<div class="icon-wrap">
				<span class="iconfont icon-A" :class="{'active': showTag == 0 && isShowSetting}" @click="showSetting(0)"></span>
			</div>
		</div>
	</transition>
	<transition name="slide-up">
		<div class="setting-wrap" v-show="isShowSetting">
			<div class="setting-font-size" v-show="showTag == 0">
				<div class="preview" :style="{'font-size':fontSizeList[0].fontSize + 'px'}">A</div>
				<div class="select">
					<div class="select-wrapper"
						v-for="(item,index) in fontSizeList"
						:key="index"
						@click="setFontSize(item.fontSize)"
					>
						<div class="line"></div>
						<div class="point-wrapper">
							<div class="point" v-show="defaultFontSize === item.fontSize">
								<div class="smail-point"></div>
							</div>
						</div>
						<div class="line"></div>
					</div>
				</div>
				<div class="preview" :style="{'font-size':fontSizeList[fontSizeList.length - 1].fontSize + 'px'}">A</div>
			</div>
			<div class="setting-theme" v-show="showTag == 1">
				<div class="theme-wrappre"
					v-for="(item,index) in themesList"
					:key="index"
					@click="setTheme(index)"
				>
					<div class="preview" 
					:style="{'background':item.style.body.background}"
					:class="{'no-border':item.style.body.background != '#fff'}"
					></div>
					<span class="text" :class="{'selected': index === defaultTheme}">{{item.name}}</span>
				</div>
			</div>
			<div class="setting-progress" v-show="showTag == 2">
				<div class="progress-wrapper">
					<input type="range" class="progress"
						max="100"
						min="0"
						step="1"
						@change="onPregressChange($event.target.value)"
						@input="onProgressInput($event.target.value)"
						:value="progress"
						:disabled="!bookAvailable"
						ref="progress"
					>
				</div>
				<div class="text-wrapper">
					<span>{{bookAvailable ? progress + '%' : '加载中...'}}</span>
				</div>
			</div>
		</div>
	</transition>
	<content-view
		v-show="ifShowContent"
		:bookAvailable="bookAvailable"
		:navigation="navigation"
		@jumpTo="jumpTo"
	></content-view>
	<transition name="fade">
		<div class="content-mask"
			v-show="ifShowContent"
			@click="hideContent"
		></div>
	</transition>
  </div>
</template>

<script>
import ContentView from './ContentView'
export default {
  name: 'MenuBar',
  components: {
	  ContentView
  },
  props:{
  	ifTitleAndMenuShow: {
  		type: Boolean,
  		default: false
  	},
  	fontSizeList: Array,
	defaultFontSize: Number,
	themesList: Array,
	defaultTheme: Number,
	bookAvailable: Boolean,
	navigation: Object
  },
  data(){
  	return {
		  isShowSetting: false,
		  showTag: 0,
		  progress: 0,
		  ifShowContent: false
  	}
  },
  methods: {
	jumpTo(target){
		this.$emit('jumpTo',target)
		this.ifShowContent = false
	},
	showContent() {
		this.ifShowContent = true
		this.$emit('hideTitleAndMenu')
	},
	hideContent(){
		this.ifShowContent = false
	},
	onPregressChange(value) {
		this.$emit('onPregressChange',value)
	},
	onProgressInput(value) {
		this.progress = value
		this.$refs.progress.style.backgroundSize = `${this.progress}% 100%`
		
	},
	setTheme(index){
		this.$emit('setTheme',index)
	},
  	setFontSize(fontSize) {
  		this.$emit('setFontSize',fontSize)
  	},
  	showSetting(tag) {
		  this.isShowSetting = true
		  this.showTag = tag
  	},
  	hideSetting() {
  		this.isShowSetting = false
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

.menu-bar {
	.menu-wrap {
		position: absolute;
		bottom: 0;
		left: 0;
		z-index: 101;
		width: 100%;
		height: px2rem(48);
		background: #fff;
		display: flex;
		box-shadow: 0 px2rem(-8) px2rem(8) rgba(0,0,0,.15);
		&.hode-boxshadow {
			box-shadow: none;
		}
		.icon-wrap {
			flex: 1;
			@include center;
			.iconfont {
				&.icon-jindu {
					font-size: px2rem(18);
				}
				&.icon-liangdu {
					font-size: px2rem(24);
				}
				&.icon-A {
					font-size: px2rem(18)
				}
				&.active {
					color: #2196F3;
				}
			}
		}
	}
	.setting-wrap {
		position: absolute;
		bottom: px2rem(48);
		left: 0;
		z-index: 101;
		width: 100%;
		height: px2rem(60);
		background: #fff;
		box-shadow: 0 px2rem(-8) px2rem(8) rgba(0,0,0,.15);
		.setting-font-size {
			display: flex;
			height: 100%;
			.preview {
				flex: 0 0 px2rem(40);
				@include center;
			}
			.select {
				display: flex;
				flex: 1;

				.select-wrapper {
					display: flex;
					flex: 1;
					align-items: center;
					&:first-child {
						.line {
							&:first-child {
								border-top: none;
							}
						}
					}
					&:last-child {
						.line {
							&:last-child {
								border-top: none;
							}
						}
					}
					.line {
						flex: 1;
						height: 0;
						border-top: px2rem(1) solid #ccc;
					}
					.point-wrapper {
						position: relative;
						width: 0;
						height: px2rem(7);
						border-left: px2rem(1) solid #ccc;
						flex: 0 0 0;
						.point {
							position: absolute;
							top: px2rem(-8);
							left: px2rem(-10);
							height: px2rem(20);
							width: px2rem(20);
							border-radius: 50%;
							background: #fff;
							border: px2rem(1) solid #ccc;
							box-shadow: 0 px2rem(4) px2rem(4) rgba(0,0,0,.15);
							@include center;
							.smail-point {
								width: px2rem(5);
								height: px2rem(5);
								background: #000;
								border-radius: 50%;
							}
						}
					}
				}
			}
		}
		.setting-theme {
			display: flex;
			height: 100%;
			.theme-wrappre {
				flex: 1;
				display: flex;
				flex-direction: column;
				padding: px2rem(5);
				box-sizing: border-box;
				.preview{
					flex: 1;
					border: px2rem(1) solid #ccc;
					box-sizing: border-box; 
					&.no-border {
						border: none;
					}
				}
				.text{
					flex: 0 0 px2rem(20);
					font-size: px2rem(14);
					color: #ccc;
					@include center;
					&.selected {
						color: #333;
					}
				}
			}
		}
		.setting-progress {
			position: relative;
			height: 100%;
			width: 100%;
			.progress-wrapper {
				width: 100%;
				height: 100%;
				padding: 0 px2rem(30);
				@include center;
				box-sizing: border-box;
				.progress {
					width: 100%;
					-webkit-appearance: none;
					height: px2rem(2);
					background: -webkit-linear-gradient(#333,#333) no-repeat, #ddd;
					background-size: 0 100%;
					&:focus {
						outline: none;
					}
					&::-webkit-slider-thumb {
						-webkit-appearance: none;
						height: px2rem(20);
						width: px2rem(20);
						border-radius: 50%;
						background: #fff;
						box-shadow: 0 4px 4px 0 rgba(0,0,0,.15);
						border: px2rem(1) solid #ddd;
					}
				}
			}
			.text-wrapper {
				font-size: px2rem(12);
				color: #333;
				margin-top: px2rem(-14);
				@include center;
			}
		}
	}
	.content-mask {
		position: absolute;
		top: 0;
		left: 0;
		z-index: 101;
		display: flex;
		height: 100%;
		width: 100%;
		background: rgba(51,51,51,.8);
	}
}

</style>
