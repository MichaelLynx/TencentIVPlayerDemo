//
//  AnalyzeInterface.h
//  GuitarProject
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#ifndef AnalyzeInterface_h
#define AnalyzeInterface_h
#pragma mark - 公共接口
/**
 * 激活账户
 * PATCH
 * usr  邮箱
 * pwd 密码
 */
#define Kaccount_activation @"api/acm/app/v1/public/account/activation"

/**
 * 激活账户
 * PATCH
 * usr  邮箱
 * pwd 密码
 */
#define Kaccount_v2_activation @"api/acm/app/v2/public/account/activation"

/**
 * 发送激活验证码
 * GET
 * email  登录时的邮箱
 */
#define Kactivate_email_code @"api/acm/app/v1/public/email/activateCode?email={XXXX}"

/**
 * 登录
 * POST
 * usr  用户账号名称(邮箱)
 * pwd 密码(6-12位)(密码+数字)
 * mac 验证码（1通用）
 */
#define Klogin @"/open/developer/acm/v1/openUser/login"

/**
 * 获取登录处盐值
 * GET
 * userName  邮箱
 */
#define KgetSaltKey @"api/sso/web/v1/com/public/saltKey/login?loginType=app&userName={XXXX}"

/**
 * 获取权限列表
 * GET
 * userId  用户信息唯一标识
 */
#define Kusers_powers @"api/acm/app/v1/users/{XXXX}/powers"

/**
 * 获取周的时间范围
 * GET
 * idx  Bearer eyJhbGXXXXXXciOiJIUzI1NiJ9
 */
#define Kweek_duration @"api/att/app/v1/common/week/duration?idx={XXXX}"

/**
 * 获取薪酬周期的时间范围
 * GET
 * idx  Bearer eyJhbGXXXXXXciOiJIUzI1NiJ9
 */
#define Kperiod_duration @"api/att/app/v1/common/period/duration?idx={XXXX}"

/**
 * 刷新token
 * POST
 * userId  用户信息唯一标识
 * refreshToken  授权token
 */
#define Ktoken_refresh @"api/sso/app/v1/token/refresh"

/**
 * 登出
 * GET
 */
#define Klogout @"api/sso/app/v1/logout"

/**
 * 发送验证码
 * GET
 * email  登录时的邮箱
 */
#define Kemail_code @"api/acm/app/v1/public/email/code?email={XXXX}"
/**
 * 提交验证码
 * POST
 * email  登录时的邮箱
 * code 长度6位的数值验证码
 */
#define Kemail_code_verification @"api/acm/app/v1/public/emails/code/verification"

/**
 * 忘记密码
 * POST
 * email  登录时的邮箱
 * code 长度6位的数值验证码
 * password  重新设定的密码
 */
#define Kpassword_forget @"api/acm/app/v1/public/password/forget"

/**
 * 上传附件
 * POST
 * files  多文件流
 */
#define Kcommon_upload @"api/att/app/v1/common/attachments/upload"

//


/**
 * 获取广告页
 * Get
 */
#define Kpublic_ad @"/api/acm/app/v1/public/advertisements"//@"api/acm/app/v1/public/ad"

#pragma mark - PersonProfile
/**
 * 员工修改密码
 * PATCH
 * userId 用户信息唯一标识码
 * oldPassword 原始密码(旧密码)
 * newPassword 新密码
 */
#define Kpassword_update @"api/acm/app/v1/users/password/update"

/**
 * 登记员工可见光人脸照片
 * POST
 * file
 */
#define Kfaces_enroll @"api/pers/app/v1/employees/faces/enroll"

/**
 * 保存员工可见光人脸照片
 * POST
 * faceRequestId 可见光人脸申请id(空串是为新增操作，id有值时为更新操作)
 * employeeId  员工信息唯一标识
 * url  人脸可见光图片路径
 */
#define Kfaces_save @"api/pers/app/v1/employees/faces/save"

/**
 * 获取员工详情数据
 * GET
 * employeeId 员工信息唯一标识
 */
#define Kemployees @"api/pers/app/v1/employees/{XXXX}"

#pragma mark - 三、员工

#pragma mark - Overview
/**
 * 获取员工日统计数据
 * GET
 * employeeId 员工信息唯一识别码
 */
#define Kday_total @"api/att/app/v1/employees/day/total?employeeId={XXXX}"

/**
 * 获取员工周统计数据
 * GET
 * employeeId 员工信息唯一识别码
 */
#define Kweek_total @"api/att/app/v1/employees/week/total?employeeId={XXXX}"

/**
 * 获取员工周排班数据
 * GET
 * employeeId 员工信息唯一识别码
 */
#define Kweek_schedules @"api/att/app/v1/employees/week/schedules?employeeId={XXXX}"

/**
 * 获取员工周打卡数据
 * GET
 * employeeId 员工信息唯一识别码
 */
#define Kweek_punches @"api/att/app/v1/employees/week/punches?employeeId={XXXX}"

/**
 * 获取员工休假数据
 * GET
 * employeeId 员工信息唯一识别码
 */
#define Kweek_timeoff @"api/att/app/v1/employees/week/timeoff?employeeId={XXXX}"

#pragma mark - My Work

/**
 * 获取用户分配定点地址数据
 * GET
 * employeeId 员工信息唯一识别码
 */
#define Kusers_locations @"api/acm/app/v1/users/locations?employeeId={XXXX}"

/**
 * 获取用户App Access配置
 * GET
 * employeeId 员工信息唯一识别码
 */
#define Kusers_config @"api/acm/app/v1/users/config?employeeId={XXXX}"

/**
 * 获取当前My Work的状态
 * GET
 * employeeId 员工信息唯一识别码

 */
#define Kemployees_current @"api/att/app/v1/employees/current/state?employeeId={XXXX}"

/**
 * 获取员工My Work-in数据
 * GET
 * employeeId 员工信息唯一识别码
 * dayChangeTime 日变更时间(分钟)
 */
#define Kemployees_in @"api/att/app/v1/employees/in?employeeId={XXXX}"

/**
 * 获取员工My Work-out数据
 * GET
 * employeeId 员工信息唯一识别码
 * dayChangeTime 日变更时间(分钟)
 */
#define Kemployees_out @"api/att/app/v1/employees/out/?employeeId={XXXX}"

/**
 * 保存员工签到打卡数据
 * POST
 * employeeId 员工信息唯一识别码
 * destination 目的地
 * location 打卡时所处位置的说明
 * longitude 打卡时所处位置的经度信息(double类型)
 * latitude 打卡时所处位置的纬度信息(double类型)
 * attachments 附件(图片url地址)
 * remark 附件备注
 */
#define Kemployees_checkin @"api/att/app/v1/employees/checkin"

/**
 * 保存员工签退打卡数据
 * POST
 * punchId 签到卡id
 * employeeId 员工信息唯一识别码
 * destination 目的地
 * location 打卡时所处位置的说明
 * longitude 打卡时所处位置的经度信息(double类型)
 * latitude 打卡时所处位置的纬度信息(double类型)
 * attachments 附件(图片url地址)
 * remark 附件备注
 */
#define Kemployees_checkout @"api/att/app/v1/employees/checkout"

/**
 * 保存员工打卡轨迹数据
 * POST
 * punchId 签到卡id
 * longitude 打卡时所处位置的经度信息(double类型)
 * latitude 打卡时所处位置的纬度信息(double类型)
 */
#define Kemployees_punch_tracks @"api/att/app/v1/employees/punch/tracks"

/**
 * 保存员工Report数据
 * POST
 * punchId 签到卡id
 * employeeId 员工信息唯一识别码
 * location 打卡时所处位置的说明
 * longitude 打卡时所处位置的经度信息(double类型)
 * latitude 打卡时所处位置的纬度信息(double类型)
 * attachments 附件(图片url地址)
 * remark 附件备注
 */
#define Kemployees_punch_attachments @"api/att/app/v1/employees/punch/attachments"

#pragma mark - Time Sheet
/**
 * 获取员工日历异常数据
 * GET
 * employeeId 员工信息唯一标识
 * startFromDate 开始时间(时间戳)
 * endToDate 结束时间(时间戳)
 */
#define Kcalendar_abnormals @"api/att/app/v1/employees/calendar/abnormals?employeeId={XXXX}"

/**
 * 获取员工日打卡数据
 * GET
 * employeeId 员工信息唯一标识
 * searchDate 查询日期(时间戳)
 */
#define Kday_punches @"api/att/app/v1/employees/day/punches?employeeId={XXXX}"

/**
 * 获取员工打卡数据
 * GET
 * punchId 打卡信息唯一标识
 */
#define Kemployees_punches @"api/att/app/v1/employees/punches/{XXXX}"
/**
 * 获取打卡轨迹数据
 * GET
 * punchId 打卡信息唯一标识
 */
#define Kpunches_tracks @"api/att/app/v1/employees/punch/tracks?punchId={XXXX}"

#pragma mark - My Requests

/**
 * 获取员工申请待审核列表数据
 * GET
 * employeeId 员工信息唯一标识
 * curPage  第几页
 * pageSize  数量
 */
#define Kpending_requests @"api/aprv/app/v1/employees/pending/requests?employeeId={XXXX}"

/**
 * 获取员工申请已审核列表数据
 * GET
 * employeeId 员工信息唯一标识
 * curPage  第几页
 * pageSize  数量
 */
#define Kapproved_requests @"api/aprv/app/v1/employees/approved/requests?employeeId={XXXX}"

/**
 * 获取员工请假申请类型数据
 * GET
 */
#define Kleave_types @"api/att/app/v1/employees/leave/types"

/**
 * 获取员工加班申请类型数据
 * GET
 */
#define Kovertime_types @"api/att/app/v1/employees/overtime/types"

/**
 * 提交员工补签申请数据
 * POST
 * employeeId  员工信息唯一标识(申请人)
 * adjustmentDateTime  补签时间(时间戳)
 * adjustmentType  补签类型(0-补签到卡，1-补签退卡)
 * remark  备注信息
 */
#define Kadjustment_requests @"api/aprv/app/v1/employees/adjustment/requests"

/**
 * 提交员工请假申请数据
 * POST
 * employeeId  员工信息唯一标识(申请人)
 * payCodeId  薪酬支付代码
 * startDateTime  开始时间(时间戳)
 * endDateTime  结束时间(时间戳)
 * attachments  附件列表(图片url)
 * remark  备注信息
 */
#define Kleave_requests @"api/aprv/app/v1/employees/leave/requests"

/**
 * 提交员工加班申请数据
 * POST
 * employeeId  员工信息唯一标识(申请人)
 * payCodeId  薪酬支付代码
 * startDateTime  开始时间(时间戳)
 * endDateTime  结束时间(时间戳)
 * attachments  附件列表(图片url)
 * remark  备注信息
 */
#define Kovertime_requests @"api/aprv/app/v1/employees/overtime/requests"

/**
 * 撤销员工申请
 * POST
 * applicantId  员工信息唯一标识(申请人)
 * businessKey  审批流业务码
 */
#define Krequests_revoke @"api/aprv/app/v1/employees/requests/revoke"

#pragma mark - 四、Admin

#pragma mark - Team Attendance
/**
 * 获取团队考勤日统计面板数据
 * GET
 * employeeId 员工信息唯一标识
 * searchDate 查询日期(时间戳)
 */
#define Kdaily_statistics @"api/att/app/v1/teams/attendance/daily/statistics?employeeId={XXXX}"
/**
 * 获取团队考勤日统计面板详情数据
 * GET
 * employeeId 员工信息唯一标识
 * searchDate 查询日期(时间戳)
 * type 查询类型(present, lateIn, earlyOut, absent, leave)
 */
#define Kstatistics_detail @"api/att/app/v1/teams/attendance/daily/statistics/detail?employeeId={XXXX}"
/**
 * 获取团队时间卡区间统计面板数据
 * GET
 * employeeId 员工信息唯一标识
 * startFromDate 开始时间戳
 * endToDate 结束时间戳
 */
#define Kstatistics_duration @"api/att/app/v1/teams/timecard/duration/statistics?employeeId={XXXX}"
/**
 * 获取团队时间卡区间统计面板详情列表数据
 * GET
 * employeeId 员工信息唯一标识
 * type 查询类型(regular, overtime, leave)
 * startFromDate 开始时间戳
 * endToDate 结束时间戳
 */
#define Kstatistics_duration_list @"api/att/app/v1/teams/timecard/duration/statistics/list?employeeId={XXXX}"

#pragma mark - My Team
/**
 * 获取团队员工列表数据
 * GET
 * employeeId 员工信息唯一标识
 * curPage 第几页
 * pageSize 数量
 * filter 过滤条件(工号、姓名)
 */
#define Kteams_employees @"api/pers/app/v1/teams/employees?employeeId={XXXX}"

/**
 * 获取员工登记信息
 * GET
 * employeeId 员工信息唯一标识
 */
#define Kteams_employees_enrollment @"api/att/app/v1/teams/employees/enrollment?employeeId={XXXX}"
/**
 * 登记团队员工可见光人脸照片
 * POST
 * file 文件流
 */
#define Kteams_employees_faces @"api/pers/app/v1/employees/faces/enroll"

/**
 * 保存团队员工可见光人脸照片
 * POST
 * faceRequestId 可见光人脸申请id(空串是为新增操作，id有值时为更新操作)
 * employeeId 员工信息唯一标识
 * url 人脸可见光图片路径
 */
#define Kemployees_faces_enroll @"api/pers/app/v1/employees/faces/enroll"

/**
 * 获取员工详情数据
 * GET
 * employeeId 员工信息唯一标识
 */
#define Kpers_employees @"api/pers/app/v1/employees/{XXXX}"
/**
 * 邀请团队员工
 * POST
 * employeeId 员工信息唯一标识
 */
#define Kemployees_invite @"api/acm/app/v1/teams/employees/invite"

#pragma mark - My Approval

/**
 * 获取员工审批待审核列表数据
 * GET
 * employeeId 员工信息唯一标识
 * curPage  第几页
 * pageSize  数量
 */
#define Kpending_approvals @"api/aprv/app/v1/employees/pending/approvals?employeeId={XXXX}"
/**
 * 获取员工审批待审核详情数据
 * GET
 * requestId 申请信息唯一标识
 * requestType  申请类型(AP, LEAVE, OT)
 */
#define Kemployees_requests @"api/aprv/app/v1/employees/requests/{XXXX}"

/**
 * 通过员工申请数据
 * POST
 * businessKey 业务("AP$c2e045fc-b6e5-47ec-b90c-257b4631b52a")
 * employeeId 员工信息唯一标识
 * comment  批注
 */
#define Kapprovals_approve @"api/aprv/app/v1/employees/approvals/approve"

/**
 * 拒绝员工申请数据
 * POST
 * businessKey 业务("AP$c2e045fc-b6e5-47ec-b90c-257b4631b52a")
 * employeeId 员工信息唯一标识
 * comment  批注
 */
#define Kapprovals_revoke @"api/aprv/app/v1/employees/approvals/revoke"

/**
 * 获取员工审批历史审核列表数据
 * GET
 * employeeId 员工信息唯一标识
 * curPage  第几页
 * pageSize  数量
 */
#define Khistory_approvals @"api/aprv/app/v1/employees/history/approvals?employeeId={XXXX}"

/**
 * 保存员工补签数据
 * POST
 * approvalUserId 员工信息唯一标识(审批人)
 * employeeId 员工信息唯一标识(申请人)
 * adjustmentDateTime  补签的时间(时间戳)
 * adjustmentType  补签类型(0-补签到卡，1-补签退卡)
 * remark  备注信息
 */
#define Kemployees_adjustment @"api/aprv/app/v1/employees/adjustment"

/**
 * 保存员工请假数据
 * POST
 * approvalUserId 员工信息唯一标识(审批人)
 * employeeId 员工信息唯一标识(申请人)
 * payCode  薪酬代码
 * startDateTime  开始时间(时间戳)
 * endDateTime  结束时间(时间戳)
 * attachments  附件(图片url)
 * remark  备注信息
 */
#define Kemployees_leave @"api/aprv/app/v1/employees/leave"

/**
 * 保存员工加班数据
 * POST
 * approvalUserId 员工信息唯一标识(审批人)
 * employeeId 员工信息唯一标识(申请人)
 * payCode  薪酬代码
 * startDateTime  开始时间(时间戳)
 * endDateTime  结束时间(时间戳)
 * attachments  附件(图片url)
 * remark  备注信息
 */
#define Kemployees_overtime @"api/aprv/app/v1/employees/overtime"

#pragma mark - 五、Message Center
/**
 * 获取员工未读消息数数据
 * GET
 * employeeId 员工信息唯一标识
 */
#define Kunread_number @"api/att/app/v1/employees/alerts/unread/number?employeeId={XXXX}"

/**
 * 获取员工未读消息列表数据
 * GET
 * employeeId 员工信息唯一标识
 * curPage 当前页
 * pageSize 数量
 */
#define Kunread_list @"api/att/app/v1/employees/alerts/unread/list?employeeId={XXXX}"
/**
 * 清除员工未读消息数
 * PATCH
 * employeeId 员工信息唯一标识
 */
#define Kunread_clean @"api/att/app/v1/employees/alerts/unread/clean"

#pragma mark - 六、About
/**
 * 获取使用条款
 * GET
 */
#define Kabout_termsOfUse @"api/att/app/v1/about/{XXXX}/termsOfUse"

/**
 * 获取隐私声明
 * GET
 */
#define Kabout_privacyNotice @"api/att/app/v1/about/{XXXX}/privacyNotice"

/**
 * 获取安全信息
 * GET
 */
#define Kabout_security @"api/att/app/v1/about/{XXXX}/security"

/**
 * 获取帮助与支持
 * GET
 */
#define Kabout_help @"api/att/app/v1/about/help"

/**
 * 获取版权信息
 * GET
 */
#define Kabout_copyright @"api/att/app/v1/about/copyright"

#pragma mark - 七、Settings
/**
 * 获取最新版本
 * GET
 * type 设备类型(1-Android，2-iPhone)
 */
#define Kversion_check @"api/att/app/v1/settings/version/check?type={XXXX}"

#pragma mark - 八、Device Management
/**
 * 1.获取设备列表
 * POST
 */
//author jolly.wu 地址改为get请求了
#define Kmembers_list @"api/thing/app/v1/members/company/list"//@"api/thing/app/v1/members"

/**
* 新增-获取有指纹功能的设备的列表
* POST
* deviceName  设备名称
* deviceSn  设备序列号
* secuKey  设备安全码
*/
#define Kmenbers_list_fd @"api/thing/app/v1/members/fingerprint"

/**
 * 2.添加设备
 * POST
 * deviceName  设备名称
 * deviceSn  设备序列号
 * secuKey  设备安全码
 */
#define Kmembers_add @"api/thing/app/v1/members"

/**
 * 3.删除设备
 * DELETE
 * id  设备主键id
 */
#define Kmembers_del @"api/thing/app/v2/members/delete"//@"api/thing/app/v1/members/{XXXX}"

/**
 * 4.修改设备名称
 * PUT
 * deviceName  设备名称
 */
#define Kmembers_name @"api/thing/app/v1/members/name/update"
//@"api/thing/app/v1/members/name/{XXXX}"
/**
 * 5.获取门禁设备列表
 * GET
 */
#define Kmembers_access_list @"api/thing/app/v1/members/access"

/**
 * 6.开门
 * POST
 * id  设备主键id
 */
#define Kevents_opendoor @"api/thing/app/v1/events/door/open"

/*
    根据国家code获取时区
    Get方式
 */
#define KzoneIdByCountryCode @"api/sys/app/v1/public/time/zone/{code}"

/*
    获取设备区域列表
 */
#define Kareas @"api/att/app/v1/areas/list"
//@"api/thing/app/v1/areas"

/*
    二维码扫码登录
 参数:
 param:{
    qrCodeValue:二维码内容
 }
 验证二维码正确性
 */
#define KconfirmQrCode @"/api/acm/web/v1/public/qrcode/confirm"

//扫码登录
/*
    qrCodeValue,
    accessToken
 */
#define KqrCodeLogin    @"/api/acm/web/v1/qrCode/login"


#pragma mark - 2.0新接口

/**
 * 获取首页授权功能，当前首页不需要授权，该接口不用
 * GET
 */
#define KhomeMenu @"/api/pfm/app/v1/permissions/home"

/**
 * 获取work下的已购买内容
 * GET
 */
#define KworkMenu @"/api/pfm/app/v1/applications/workspace"

/**
 * 获取work下的已购买内容，全列表样式。
 * GET
 */
#define KworkMenuList @"/api/auth/app/v2/applications/workspace/menu"

/**
 * 指定应用下的子菜单
 * GET
 * appId  work界面
 */
#define KworkInsideMenu @"/api/pfm/app/v2/applications/workspace/{XXXX}"
//@"/api/pfm/app/v1/applications/workspace/{XXXX}"

/**
 * Contact相关联系人及部门
 * GET
 * deptId  当前层级
 * mixedField  搜索内容，不搜索时不填写，直接为""
 */
#define KcontactList @"/api/pers/app/v1/contactBook/contacts?deptId={XXXX}"

/**
 * 获取员工信息
 * GET
 * employeeId  员工Id
 */
#define KemployeeInfo @"/api/pers/app/v1/contactBook/employees/{XXXX}"

/**
 * 获取用户本人的信息
 * GET
 * employeeId  员工Id
 */
#define KmeInfo @"/api/pers/app/v1/employees/my/{XXXX}"

/**
 * 获取message下级菜单权限
 * GET
 */
#define kmessageTypeList @"/api/pfm/app/v1/permissions/submenu/abiz01"

/**
 * 获取员⼯未读数
 * GET
 * employeeId  员工Id
 */
#define KmessageUnreadNumber @"/api/att/app/v1/employees/alerts/unread/number?employeeId={XXXX}"

/**
 * 获取员⼯未读通知类消息数据
 /api/att/app/v1/employees/alerts/unread/notice/list?employeeId={{employeeId}}&curPage=1&pageSize=5
 * GET
 * employeeId  员工Id
 * curPage  当前页面
 * &pageSize  页面大小
 */
#define KmessageNoticeList @"/api/att/app/v1/employees/alerts/unread/notice/list?employeeId={XXXX}"

/**
 * 获取员⼯未读处理类消息数据
 * GET
 /api/att/app/v1/employees/alerts/unread/operator/list?employeeId={{employeeId}}&curPage=1&pageSize=5
 * employeeId  员工Id
 * curPage  当前页面
 * &pageSize  页面大小
 */
#define kmessageOperatorList @"/api/att/app/v1/employees/alerts/unread/operator/list?employeeId={XXXX}"

/**
 * 获取系统时间
 * GET
 */
#define KservicerTime @"/api/sys/app/v1/serverTime"

/**
 * 根据工作流任务id获取信息
 * GET
 * businessKey  businessKey
 * 从消息页面跳转到审批页面
 */
#define KApprovalspendingInfo @"/api/aprv/app/v1/employees/pending/{XXXX}"

/**
 * 获取当前消息推送设置信息
 * GET
 */
#define KGetMessageSetting @"/api/note/app/v1/messageSettings/{XXXX}"

/**
 * 更新消息推送设置
 * Post
 */
#define KsetMessageSetting @"/api/note/app/v1/messageSettings"

/**
 * 员工邀请提交保存
 * POST
 */
#define Kinvite @"/api/vis/app/v1/invite"

/**
 * 历史访客列表
 * GET
 */
#define KhistoricalVisitorList @"/api/vis/app/v1/invite/visitor/list?conditionFiled={XXXX}"

/**
 * 历史记录列表
 * POST
 * conditionFiled  搜索条件字段，这边是输入的名字
 * employeeId  <#content#>
 * visitDate  <#content#>
 */
#define KvisitorHistory @"/api/vis/app/v1/histories/list"

/**
 * 访客模块列表展示
 * GET
 */
#define KvisitorList @"/api/vis/app/v1/visitors/appoint/list?employeeId={XXXX}"

/**
 * 获取已经签到但未签退访客简略信息
 * GET
 */
#define KlogbookCheckInList @"/api/vis/app/v1/logbooks/visitor/today/checkIn"

/**
 * 获取未签到或以签到的访客的简略信息
 * GET
 */
#define KlogbookList @"/api/vis/app/v1/logbooks/visitor/today"

/**
 * 获取未签到或以签到的访客详细信息(app统一接口)
 * GET
 */
#define KvisitorInfo @"/api/vis/app/v1/logbooks/appoint/{XXXX}"

/**
 * 签到(app统一接口)
 * POST
 * visitorAppointId  <#content#>
 */
#define KvisitorCheckIn @"/api/vis/app/v1/visitors/checkIn"

/**
 * 签退(复用web端签退接口、app统一接口)
 * Patch
 * visitorAppointId  <#content#>
 */
#define KvisitorCheckOut @"/api/vis/app/v1/visitors/checkOut"

/**
 * 保存健康信息
 * POST
 * visitorAppointId  预约Id
 * visitorId  访客Id
 * temperature  体温
 * temperatureUnit  体温单位
 * contactInfectedArea  是否到过感染地区(0-无; 1-有; 2-未知)
 * contactInfectedPerson  是否接触过感染人群(0-无; 1-有; 2-未知)
 * quarantineDays  已经经过的隔离天数
 */
#define KvisitorHealth @"/api/vis/app/v1/visitors/health"

/**
 * 现场创建并签到
 * POST
 */
#define KcheckIn @"/api/vis/app/v1/appoints/now"


/**
 * 保存健康信息
 * POST
 * visitorAppointId
 * visitorId
 * temperature
 * temperatureUnit
 * contactInfectedArea
 * contactInfectedPerson
 * quarantineDays
 * isolationStatus
 */
#define KvisitorSaveHealth @"/api/vis/app/v1/logbooks/visitor/healthInfo"

/**
 * 获取Health Setting
 * GET
 */
#define KgetHealthSetting @"/api/vis/app/v1/Settings/health/switch"

/**
 * 更新Health Setting
 * Patch
 * healthCheckStatus  payload/params/healthCheckStatus
 */
#define KsetHealthSetting @"/api/vis/app/v1/Settings/health"

/**
 * 扫码签到
 * POST
 * visitorAppointId  payload/params/visitorAppointId
 */
#define KvisitorQRCode @"/api/vis/app/v1/appoints/scan"

/**
 * 签到(app统一接口)
 * POST
 * visitorAppointId  payload/params/visitorAppointId
 */
#define KlogbookCheckIn @"/api/vis/app/v1/logbooks/visitor/checkIn"

/**
 * 签退(复用web端签退接口、app统一接口)
 * Patch
 * visitorAppointId  payload/params/visitorAppointId
 */
#define KlogbookCheckOut @"/api/vis/app/v1/logbooks/visitor/checkOut"

/**
 * 上传访客头像到文件服务器
 * POST
 * 请求体：图片
 */
#define KvisitorUploadAvatar @"/api/sys/app/v1/fileUpload/image"


/**
 * 访客头像地址更新接口
 * PUT
 * avatar  payload/params/avatar
 * visitor  payload/params/visitor
 */
#define KvisitorChangeAvatar @"/api/vis/app/v1/visitors/avatar/ios"

//Device

/**
 * 离线通知按钮切换
 * POST
 * id  payload/params/id
 * offlineNotifiation  payload/params/offlineNotifiation
 */
#define KsetDeviceNotify @"api/thing/app/v1/members/device/offlineMessageSettings"

/**
 * 设备已绑定的员工列表
 * POST
 * payload/
 * total  <#content#>
 * curPage  <#content#>
 * pageSize  <#content#>
 * payload/params/
 * empNoOrName  <#content#>
 * areaId  <#content#>
 */
#define KboundEmployeeList @"api/thing/app/v1/members/device/bindEmpList"

/**
 * 设备未绑定的员工列表
 * POST
 * payload/
 * total  <#content#>
 * curPage  <#content#>
 * pageSize  <#content#>
 * payload/params/
 * empNoOrName  <#content#>
 * areaId  <#content#>
 */
#define KunboundEmployeeList @"api/thing/app/v1/members/device/unBindEmpList"

/**
 * 设备已绑定的管理员列表
 * POST
 * payload/
 * total  <#content#>
 * curPage  <#content#>
 * pageSize  <#content#>
 * payload/params/
 * empNoOrName  <#content#>
 * areaId  <#content#>
 */
#define KboundAdminList @"api/thing/app/v1/members/device/bindAdminList"

/**
 * 设备未绑定的管理员列表
 * POST
 * payload/
 * total  <#content#>
 * curPage  <#content#>
 * pageSize  <#content#>
 * payload/params/
 * empNoOrName  <#content#>
 * areaId  <#content#>
 */
#define KunboundAdminList @"api/thing/app/v1/members/device/unBindAdminList"

/**
 * 员工绑定或解绑设备
 * POST
 * areaId  payload/params/areaId
 * addEmployeeIds  payload/params/addEmployeeIds
 * removeEmployeeIds  payload/params/removeEmployeeIds
 */
#define KemployeeBind @"api/thing/app/v1/members/device/employees/bind"

/**
 * 员工设置为设备管理员，或者去除管理员
 * POST
 * payload/params/XX
 * id  管理员列表的deviceAccessId
 * deviceId  <#content#>
 * devicePermission  0 -- 非管理员  14 --管理员
 * devicePassword  <#content#>
 * deviceVerifyMode  <#content#>
 * employeeId  <#content#>
 * openDoorRemotely  <#content#>
 */
#define KadminBind @"api/thing/app/v1/members/device/admins/bind"

/**
 * 员工的生物模板信息
 * GET
 * payload/params/
 * deviceId  <#content#>
 * companyId  <#content#>
 * enrollmentType  <#content#>
 * conditionFiled  <#content#>
 */
#define EmployeeEnrollment @"app/v1/device/employees/enrollment"

/**
 * 设备关联的员工和管理员数量
 * GET
 * id  deviceID
 */
#define KdeviceBoundNumber @"api/thing/app/v1/members/device/deviceBindEmpAndAdminCount?id={XXXX}"

/**
 * 获取个人当前薪酬周期的统计数据
 * GET
 * employeeId  <#content#>
 * startFromDate  <#content#>
 * endToDate  <#content#>
 */
#define KperiodStats @"/api/att/app/v1/employees/period/total?employeeId={XXXX}"

/**
 * 获取当前薪酬周期的打卡数据
 * GET
 * employeeId  <#content#>
 * startFromDate  <#content#>
 * endToDate  <#content#>
 */
#define KpunchRecords @"/api/att/app/v1/employees/period/punches?employeeId={XXXX}"

/**
 * 获取个人当前薪酬周期的排班数据
 * GET
 * employeeId  <#content#>
 * startFromDate  <#content#>
 * endToDate  <#content#>
 */
#define Kschedules @"/api/att/app/v1/employees/period/schedules?employeeId={XXXX}"

/**
 * 获取设备查询设备详细信息
 * GET
 */
#define KdeviceDetailInfo @"api/thing/app/v1/members/{XXXX}"

/**
 * 员工的生物模板信息
 * GET
 */
#define KemployeeBioInfo @"api/thing/app/v1/members/device/bioTemplate/queryByEmployee"

/**
 * 获取门列表
 * POST
 * payload/params/employeeId  员工id（获取远程开门权限列表时传）
 * payload/params/doorName  门名称
 */
#define KgetAccessDoorList @"/api/acc/app/v1/doors/list"

/**
 * 更新Door信息
 * PUT
 * payload/params/doorName  门名称
 */
#define KupdateDoorInfo @"/api/acc/app/v1/doors/doorName/"

/**
 * 发送远程开门指令
 * POST
 * payload/params/employeeId  员工id
 * payload/params/id  门id
 */
#define KremoteOpenDoor @"/api/acc/app/v1/doors/remoteOpen"

/**
 * 权限组列表
 * POST
 * payload/params/name  权限组名称
 */
#define KgetALList @"/api/acc/app/v1/accessLevels/list"

/**
 * 获取绑定权限的员工列表
 * POST
 * payload/params/id  权限组id（获取当前权限组绑定的员工列表时传）
 */
#define KgetALAssignList @"/api/acc/app/v1/accessLevels/employeeList"

/**
 * 保存权限组
 * POST
 * payload/params/XXX
 * daysConfig  时间段配置：[{"allDayStatus":0,"endTime":"23:59","startTime":"00:00","week":0},]
 * daysConfig/allDayStatus  是否开启全体时间段:0-是(全天00:00-23:59），1-否
 * daysConfig/startTime  开始时间
 * daysConfig/week  周 0～6表示周日～周六
 * defaultLevel  默认权限组：1-是，其他-否
 * periodStartDateTime  周期开始时间（当periodOfValidity=0时，传0）
 * periodEndDateTime  周期结束时间（当periodOfValidity=0时，传0）
 * name  权限组名称
 * periodOfValidity  是否开启周期时间:0-false 1-true
 * doorIdList  权限组绑定的门id列表
 * employeeIdList  权限组绑定的员工id列表
 */
#define KsaveAccessLevel @"/api/acc/app/v1/accessLevels/save"

/**
 * 更新defaultLevel状态
 * PUT
 * id  权限组id
 * payload/params/defaultLevel  默认权限组：1-是，其他-否
 */
#define KupdateALDefaultLevel @"/api/acc/app/v1/accessLevels/defaultLevel/status/"

/**
 * 更新权限组名称
 * PUT
 * id  权限组id
 * payload/params/name  权限组名称
 */
#define KupdateALName @"/api/acc/app/v1/accessLevels/name/"

/**
 * 保存权限组和人的关系
 * POST
 * payload/params/levelId  权限组id
 * payload/params/employeeIdList  员工id集合
 */
#define KsaveALAssignEmployee @"/api/acc/app/v1/accessLevels/employee/save"

/**
 * 保存权限组和门的关系
 * POST
 * payload/params/levelId  权限组id
 * payload/params/doorIdList  门id集合
 */
#define KsaveALAssignDoor @"/api/acc/app/v1/accessLevels/door"

/**
 * 更新timeZone
 * PUT
 * id  权限组id
 * payload/params/name  名称
 * payload/params/daysConfig  时间段配置：[{"allDayStatus":0,"endTime":"23:59","startTime":"00:00","week":0},]
 */
#define KupdateALTimezone @"/api/acc/app/v1/accessLevels/accessTimeZone/"

/**
 * 更新权限组时间周期Open Cycle
 * PUT
 * id  权限组id
 * payload/params/timeZoneId  timeZoneId
 * payload/params/daysConfig  时间段配置：[{"allDayStatus":0,"endTime":"23:59","startTime":"00:00","week":0},]
 * payload/params/periodOfValidity  是否开启周期时间:0-false 1-true
 * payload/params/periodStartDateTime  周期开始时间（当periodOfValidity=0时，传0）
 * payload/params/periodEndDateTime  周期结束时间（当periodOfValidity=0时，传0）
 */
#define KupdateALOpenCircle @"/api/acc/app/v1/accessLevels/"

/**
 * 删除权限组
 * DELETE
 * id  权限组id——params/ids
 * payload/params  nil——加密
 */
#define KdeleteAccessLevel @"/api/acc/app/v2/accessLevels/delete"//@"/api/acc/app/v1/accessLevels/"

/**
 * 开门记录
 * POST
 * payload/curPage
 * payload/pageSize
 * payload/params/eventStatus  状态： 1 异常（全部开门记录不要传）
 * payload/params/beginTime  开始时间
 * payload/params/endTime  结束时间
 * payload/params/remoteOpen  是否远程开门：0-否，1是
 * payload/params/doorIds  门ID集合
 */
#define KgetAccessRecord @"/api/acc/app/v1/eventsRecords/paging"

/**
 * 获取最新一条开门记录
 * POST
 * payload/params
 */
#define KgetLastAccessRecord @"/api/acc/app/v1/eventsRecords/latest"

/**
 * 报警设置
 * POST
 * payload/params/employeeId  员工id
 * payload/params/type  类型：1- accessLevelExpire, 2- exceptionEvent
 * payload/params/status  开启状态：0-关闭，1-开启
 */
#define KsetAccessAlertSetting @"/api/acc/app/v1/accessLevels/alterSetting"

/**
 * 获取报警设置
 * POST
 * payload/params/employeeId  员工id
 * payload/params/type  类型：1- accessLevelExpire, 2- exceptionEvent
 */
#define KgetAccessAlertSetting @"/api/acc/app/v1/accessLevels/getAlertSetting"

/**
 * 获取门状态
 * GET
 * id  门id
 */
#define KgetAccessDoorStatus @"/api/acc/app/v1/doors/status/{XXXX}"

#pragma mark - Health

/**
 * 查询防疫设置信息
 * GET
 */
#define getHealthSetting @"/api/heal/app/v1/healthSetting/findByCompanyId"

/**
 * 更新防疫设置信息
 * PUT
 * id  防疫设置id
 * payload/params/temperatureCheck  是否开启体温检测（0-禁用， 1-启用）
 * payload/params/temperatureUnit  体温单位（0-摄氏度， 1-华氏度）
 * payload/params/temperatureLowest  最低体温阀值
 * payload/params/temperatureHighest  最高体温阀值
 * payload/params/faceMaskCheck  是否检测佩戴口罩（0-不检查，1-检查）
 * payload/params/contactAreaCheck  是否检查到过危险区域 （0-不检查，1-检查）
 * payload/params/contactAreaCheckDays  多少天内到过危险区域
 * payload/params/contactPersonCheck  是否检查与感染人群接触（0-不检查，1-检查）
 * payload/params/quarantineDaysCheck  检查是否隔离（0-不检查，1-检查）
 */
#define setHealthSetting @"/api/heal/app/v1/healthSetting/"

/**
 * 获取员工防疫记录信息
 * GET
 */
#define getHealthEmployeeRecord @"/api/heal/app/v1/health/employees"

/**
 * 获取访客防疫记录
 * GET
 */
#define getHealthVisitorRecord @"/api/heal/app/v1/health/visitors"

/**
 * 绑定极光推送id与员工id
 * POST
 * employeeId  <#content#>
 * registrationID  <#content#>
 */
#define KBindJpushAndEmployee @"/api/acm/app/v1/jg/pusher/regId"


#pragma mark - 可视对讲相关接口

/**
 * 终端用户注册
 * POST
 * userId  用户ID
 */
#define kTCreateUser @"/open/developer/iot/app/v1/tencentIot/createAppUser"

/**
 * 终端用户绑定设备
 * POST
 * accessId  终端用户在IoT Video上的唯一标识ID
 * tid  设备TID
 * role  用户角色，owner：主人，guest：访客
 * forceBind  是否踢掉之前的主人，true：踢掉；false：不踢掉。
 */
#define kTBind @"/open/developer/iot/app/v1/tencentIot/createBinding"

/**
 * 终端用户临时访问设备授权
 * POST
 * accessId  客户的终端用户在IoT Video上的唯一标识ID
 * tidList  设备TID列表，以 , 分开，如"dfd44vvv,fdafd45345,65465ghg"
 */
#define kTCreateDevToken @"/open/developer/iot/app/v1/tencentIot/createDevToken"

/**
 * 终端用户接入授权
 * POST
 * accessId  客户的终端用户在IoT Video上的唯一标识ID
 * uniqueId  终端唯一ID，用于区分同一个用户的多个终端
 */
#define kTCreateUsrToken @"/open/developer/iot/app/v1/tencentIot/createUsrToken"

/**
 * 终端用户解绑设备
 * POST
 * accessId  终端用户在IoT Video上的唯一标识ID
 * tid  设备id
 * role  用户角色，owner：主人，guest：访客
 */
#define kTUnbind @"/open/developer/iot/app/v1/tencentIot/deleteBinding"

/**
 * 查询终端用户绑定的设备列表
 * POST
 * accessId  终端用户在IoT Video上的唯一标识ID
 */
#define kTGetUserDeviceList @"/open/developer/iot/app/v1/tencentIot/findDevListByUser"

/**
 * 查询设备绑定的终端用户列表
 * POST
 * accessId  终端用户在IoT Video上的唯一标识ID
 * tid  设备TID
 */
#define kTGetDeviceUserList @"/open/developer/iot/app/v1/tencentIot/findUserListByDev"

/**
 * 查询用户的注册状态
 * POST
 * unionId  终端用户的唯一ID列表
 */
#define kTGetUserRegiStatus @"/open/developer/iot/app/v1/tencentIot/findUserRegistrationStatus"

/**
 * 删除终端用户
 * POST
 * unionId  客户的终端用户在IoT Video上的唯一标识ID
 */
#define kTDeleteUser @"/open/developer/iot/app/v1/tencentIot/deleteAppUsr"

/**
 * 停止设备推拉流
 * POST
 * tids  设备TID列表
 */
#define kTStopStream @"/open/developer/iot/app/v1/tencentIot/disableDeviceStream"

/**
 * 开启设备推流
 * POST
 * tids  设备TID列表
 */
#define kTOpenStream @"/open/developer/iot/app/v1/tencentIot/runDeviceStream"

/**
 * 禁用设备
 * POST
 * tids  设备TID列表
 */
#define kTBanDevice @"/open/developer/iot/app/v1/tencentIot/disableDevice"

/**
 * 启用设备
 * POST
 * tids  设备TID列表
 */
#define kTRunDevice @"/open/developer/iot/app/v1/tencentIot/runDevice"

/**
 * 获取设备信息
 * POST
 * tid  设备TID
 */
#define kTGetDeviceInfo @"/open/developer/iot/app/v1/tencentIot/describeDevice"

/**
 * 获取设备列表
 * POST
 * curPage  <#content#>
 * pageSize  <#content#>
 * returnModel  是否返回全量数据
 * deviceName  设备名称，支持左前缀模糊匹配
 */
#define kTGetDeviceList @"/open/developer/iot/app/v1/tencentIot/iotDevice/deviceList"

/**
 * <#title#>
 * <#GET#>
 * <#key#>  <#content#>
 * <#key#>  <#content#>
 * <#key#>  <#content#>
 */
//#define <#content#> @"<#content#>"

//{XXXX}

#endif /* AnalyzeInterface_h */

