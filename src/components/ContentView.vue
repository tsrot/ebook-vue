<template>
  <transition name="slide-right">
      <div class="content">
        <div class="content-title">目 录</div>
        <div class="content-wrapper" v-if="bookAvailable">
          <div class="content-item"
            v-for="(item,index) in navigation.toc"
            :key="index"
            @click="jumpTo(item.href)"
          >
            <span class="text">{{item.label}}</span>
          </div>
        </div>
        <div class="empty" v-else >加载中...</div>
    </div>
  </transition>
</template>

<script>
export default {
  props:{
    bookAvailable: Boolean,
    navigation: Object
  },
  methods:{
    jumpTo(target) {
      this.$emit('jumpTo',target)
    }
  }
}
</script>

<style lang='scss' scoped>
$fontSize: 37.5;
@function px2rem($px){
	@return ($px / $fontSize) + rem;
}
@mixin center {
	display: flex;
	justify-content: center;
	align-items: center;
}

.content {
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    width: 80%;
    overflow: hidden;
    background: #fff;
    z-index: 102;
    display: flex;
    flex-direction: column;
    .content-title {
      flex: 1;
      width: 80%;
      line-height: px2rem(50);
      font-size: px2rem(14);
      color: #333;
      font-weight: 600;
      position: fixed;
      top: 0;
      left: 0;
      text-align: center;
      border-bottom: 1px solid #eee;
      background: #fff;
    }
    .content-wrapper {
      flex: 1;
      width: 100%;
      height: 100%;
      overflow: auto;
      padding: 0 px2rem(20);
      margin-top: px2rem(50);
      box-sizing: border-box;
      .content-item {
        width: 100%;
        height: px2rem(40);
        line-height: px2rem(40);
        overflow: hidden;
        display: flex;
        .text{
          display: inline-block;
          font-size: px2rem(14);
          color: #333;
        }
      }
    }
}
</style>
