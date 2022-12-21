package com.hwfs.rc.rcg.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.rc.rcg.dao.CouponMgntDAO;

 /**
 * 쿠폰번호를 관리하는 CouponMgnt Service Implementation
 * 
 * @ClassName CouponMgntServiceImpl.java
 * @Description CouponMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.05    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.06.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponMgntService")
public class CouponMgntServiceImpl extends DefaultServiceImpl implements CouponMgntService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CouponMgntDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponMgntDAO")
	private CouponMgntDAO couponMgntDAO;
	

	/**
	 * 쿠폰번호 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return couponMgntDAO.selectList(mapParam);
	}
	

	/**
	 * selectCouponStatus 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.rcg.service.CouponMgntService#selectCouponStatus(java.util.Map)
	*/
	@Override
	public RecordSet selectCouponStatus(Map<String, Object> mapParam)	throws Exception {
		
		long verify = Long.parseLong(mapParam.get("code").toString());
		int flag = 0;
		
		while ( verify > 0 ) {
			flag += verify%10;
			verify/=10;
		}
		
		if ( flag != Integer.parseInt( mapParam.get("ofs").toString()) ) {
			throw new BizException("쿠폰정보가 올바르지 않습니다.");
		}
		
		
		RecordSet rs = couponMgntDAO.selectCouponStatus(mapParam);
		
		if ( rs.size() == 0 ) {
			throw new BizException("사용할 수 없는 쿠폰 정보입니다.");
		} else if ( rs.size() > 1 ) {
			throw new BizException("관리자에게 쿠폰정보를 확인하세요.");
		} else {
			String status = null;
			status = rs.get(0).get("couponStatusNm").toString();
			
			if ( !"배포".equals(status.toString()) && !"판매".equals(status.toString()) ) {
				//throw new BizException("현재 쿠폰의 상태가 [" + status + "] 입니다.");
			}
		}
		
		return rs;
	}

}
