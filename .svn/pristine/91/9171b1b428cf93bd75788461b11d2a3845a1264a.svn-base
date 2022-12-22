package com.hwfs.ms.cmn.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ms.cmn.dao.MobileCommonDAO;
import com.hwfs.sc.cmn.util.DateUtil;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 모바일 공통 서비스하는 MobileCommon Service Implementation
 * 
 * @ClassName MobileCommonServiceImpl.java
 * @Description MobileCommonServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.13    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.04.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/cmn/mobileCommonService")
public class MobileCommonServiceImpl extends DefaultServiceImpl implements MobileCommonService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MobileCommonDAO Bean 생성 */
	@Resource(name = "/ms/cmn/mobileCommonDAO")
	private MobileCommonDAO mobileCommonDAO;
	

	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		String flag = mapParam.get("flag").toString();
		String query = mapParam.get("query").toString();
		
		//logger.debug(flag);
		//logger.debug(query);
		
		Boolean bCheck = checkFlag(flag, query);
		
		if ( !bCheck ) {
			throw new BizException("올바른 접근 방법이 아닙니다. 시스템 담당자에게 문의하세요.");
		}
		return mobileCommonDAO.selectList(mapParam);
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectMenuAuthList(Map<String, Object> mapParam) throws Exception {
		return mobileCommonDAO.selectMenuAuthList(mapParam);
	}

	/**
	 * 수신된 PUSH알림 검색.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectPushList(Map<String, Object> mapParam) throws Exception {
		return mobileCommonDAO.selectPushList(mapParam);
	}
	
	/**
	 * PUSH알림 서비스 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int savePushList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		
		//logger.debug("list.size() >>>" +list.size());
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
		    insRowCnt += mobileCommonDAO.insert(rowData);
							
		}
				
		return insRowCnt;
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectMenuList(Map<String, Object> mapParam) throws Exception {
		
		return mobileCommonDAO.selectMenuList(mapParam);
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectComboAuthMenuList(Map<String, Object> mapParam) throws Exception {
		
		return mobileCommonDAO.selectComboAuthMenuList(mapParam);
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDualUpjangList(Map<String, Object> mapParam) throws Exception {
		
		return mobileCommonDAO.selectDualUpjangList(mapParam);
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다(LIMS 팀장승인 승인 반려 권한).
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectLimsAuthLevels(Map<String, Object> mapParam) throws Exception {
		
		return mobileCommonDAO.selectLimsAuthLevels(mapParam);
	}
	
	public boolean checkFlag(String flag, String key ) throws Exception {
		int num = 0;
        int sum = 0;
        int check = 0;
        num = Integer.parseInt(DateUtil.getYyyymmdd());
        //logger.debug("num=>"+num);
        while(num!=0){
            sum += num%10;
            num /= 10;
        }
        
        check = (key.replaceAll("\\p{Z}", "")).length() + sum;
        /*
        logger.debug("key=>"+key.replaceAll("\\p{Z}", ""));
        logger.debug("key.length()=>"+(key.replaceAll("\\p{Z}", "")).length());
        logger.debug("sum=>"+sum);
        logger.debug("check=>"+check);
        */
        return ( Integer.parseInt(flag) == check );

	}
}
