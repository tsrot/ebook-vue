<template>
	<div class="ebook">
		<title-bar 
			:ifTitleAndMenuShow="ifTitleAndMenuShow"
		>
		</title-bar>
		<div class="read-wrapper">
			<div id="read"></div>
			<div class="mask">
				<div class="left" @click="prevPage"></div>
				<div class="center" @click="toggleTitleAndMeun"></div>
				<div class="right" @click="nextPage"></div>
			</div>
		</div>
		<menu-bar 
			:ifTitleAndMenuShow="ifTitleAndMenuShow"
			ref="menuBar"
			:fontSizeList="fontSizeList"
			:defaultFontSize="defaultFontSize"
			:themesList="themesList"
			:defaultTheme="defaultTheme"
			@setTheme="setTheme"
			@setFontSize="setFontSize"
			:bookAvailable="bookAvailable"
			@onPregressChange="onPregressChange"
			@jumpTo="jumpTo"
			:navigation ="navigation"
			@hideTitleAndMenu="hideTitleAndMenu"
		>
		</menu-bar>
	</div>
</template>
<script>
import TitleBar from '@/components/TitleBar.vue' 
import MenuBar from '@/components/MenuBar.vue'
import Epub from 'epubjs'
const DOWNLOAD_URL = 'ebook-vue/1365.epub'
export default {
	components: {
		TitleBar,
		MenuBar
	},
	data () {
		return {
			ifTitleAndMenuShow: false,
			fontSizeList: [
				{fontSize: 12},
				{fontSize: 14},
				{fontSize: 16},
				{fontSize: 18},
				{fontSize: 20},
				{fontSize: 22},
				{fontSize: 24}
			],
			defaultFontSize: 16,
			themesList: [
				{
					name: 'default',
					style: {
						body: {
							'color': '#000','background': '#fff'
						}
					}
				},
				{
					name: 'eye',
					style: {
						body: {
							'color': '#000','background': '#ceeaba'
						}
					}
				},
				{
					name: 'night',
					style: {
						body: {
							'color': '#fff','background': '#000'
						}
					}
				},
				{
					name: 'gold',
					style: {
						body: {
							'color': '#000','background': 'rgb(241,236,226)'
						}
					}
				}
			],
			defaultTheme: 0,
			bookAvailable: false,
			navigation: {}
		}
	},
	methods: {
		jumpTo(href){
			this.rendition.display(href)
			this.hideTitleAndMenu()
		},
		hideTitleAndMenu(){
			this.ifTitleAndMenuShow = false
			this.$refs.menuBar.hideSetting()
		},
		onPregressChange(pregress){
			const percentege = pregress / 100
			const location = percentege > 0 ? this.locations.cfiFromPercentage(percentege) : 0
			this.rendition.display(location )
		},
		setTheme(index) {
			this.themes.select(this.themesList[index].name)
			this.defaultTheme = index
		},
		registerTheme() {
			this.themesList.forEach(theme => {
				this.themes.register(theme.name,theme.style)
			})
		},
		setFontSize(fontSize) {
			if(this.themes) {
				this.themes.fontSize(fontSize + 'px')
				this.defaultFontSize = fontSize
			}
		},
		showEpub() {
			this.book = new Epub(DOWNLOAD_URL)
			this.rendition = this.book.renderTo('read',{
				width: window.innerWidth,
				height: window.innerHeight,
			})
			this.rendition.display()
			this.themes = this.rendition.themes
			this.setFontSize(this.defaultFontSize)
			this.registerTheme()
			this.setTheme(this.defaultTheme) 
			this.book.ready.then(()=>{
				this.navigation = this.book.navigation
				return this.book.locations.generate()
			}).then(result=> {
				this.locations = this.book.locations
				this.bookAvailable = true 
			})
		},
		prevPage() {
			if(this.rendition){
				this.rendition.prev();
			}
		},
		nextPage() {
			if(this.rendition){
				this.rendition.next();
			}
		},
		toggleTitleAndMeun() {
			this.ifTitleAndMenuShow = !this.ifTitleAndMenuShow;
			if(!this.ifTitleAndMenuShow){
				this.$refs.menuBar.hideSetting()
			}
		}
	},
	mounted() {
		this.showEpub() 
	}
}	
</script>

<style lang="scss" scope>
$fontSize: 37.5;
@function px2rem($px){
	@return ($px / $fontSize) + rem;
}
@mixin center {
	display: flex;
	justify-content: center;
	align-items: center;
}


.ebook {
	position: relative;
	
	.read-wrapper {
		.mask {
			position: absolute; 
			top: 0;
			left: 0;
			z-index: 100;
			display: flex;
			width: 100%;
			height: 100%;
			.left {
				flex: 0 0 px2rem(100);
			}
			.center {
				flex: 1;
			}
			.right {
				flex: 0 0 px2rem(100);
			}
		}
	}
	
}
</style>