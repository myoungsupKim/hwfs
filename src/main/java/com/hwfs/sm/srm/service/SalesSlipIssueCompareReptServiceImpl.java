package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.srm.dao.SalesSlipIssueCompareReptDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 영업전표발행비교 조회하는 SalesSlipIssueCompareRept Service Implementation
 * 
 * @ClassName SalesSlipIssueCompareReptServiceImpl.java
 * @Description SalesSlipIssueCompareReptServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.14    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 강대성
 * @since 2015.12.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/srm/salesSlipIssueCompareReptService")
public class SalesSlipIssueCompareReptServiceImpl extends DefaultServiceImpl implements SalesSlipIssueCompareReptService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SalesSlipIssueCompareReptDAO Bean 생성 */
	@Resource(name = "/sm/srm/salesSlipIssueCompareReptDAO")
	private SalesSlipIssueCompareReptDAO salesSlipIssueCompareReptDAO;
	

	/**
	 * 영업전표발행비교 조회 목록을 조회한다.
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
		
		String tabIndex = (String) mapParam.get("tabIndex");
		
		//매출액비교
		if(tabIndex.equals("0"))
		{
			return salesSlipIssueCompareReptDAO.selectTab1List(mapParam);
		}
		//채권비교
		else if(tabIndex.equals("1"))
		{
			return salesSlipIssueCompareReptDAO.selectTab2List(mapParam);
		}
		//선수금비교
		else if(tabIndex.equals("2"))
		{
			return salesSlipIssueCompareReptDAO.selectTab3List(mapParam);
		}
		
		return null;
	}
	
}
