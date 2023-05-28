// base.ts
export default class Base {
    /* 公共模块 */
    static common = process.env.NODE_ENV === "development" 
    ? "https://testCommon.com(测试线地址)" 
    : "https://produceCommon.com(生产线地址)"
    /* 活动模块 */
    static active = process.env.NODE_ENV === "development" 
    ? "https://testActive.com(活动测试线地址)" 
    : "https://produceActive.com(活动生产线地址)"
  
  }
  