package com.hwfs.batch.sc.app;

import org.springframework.scheduling.quartz.JobDetailBean;

/**
 * 식재앱 판가,자재마스터 송신 배치Scheduler 중복실행방지 JobDetailBean Class
 * @ClassName AppJobDetailBean.java
 * @Description AppJobDetailBean Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.19.   김명섭        최초생성
 * </pre>
 */
public class AppJobDetailBean extends JobDetailBean {
boolean concurrent = false;

public void setConcurrent(boolean concurrent) {
this.concurrent = concurrent;
}

public boolean isStateful() {
return !concurrent;
}
}