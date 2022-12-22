package com.hwfs.ms.mlm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.mlm.dao.WorkplaceSearchPopDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 사업장검색하는 WorkplaceSearchPop Service Implementation
 * 
 * @ClassName WorkplaceSearchPopServiceImpl.java
 * @Description WorkplaceSearchPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.12    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.03.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mlm/workplaceSearchPopService")
public class WorkplaceSearchPopServiceImpl extends DefaultServiceImpl implements WorkplaceSearchPopService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** WorkplaceSearchPopDAO Bean 생성 */
	@Resource(name = "/ms/mlm/workplaceSearchPopDAO")
	private WorkplaceSearchPopDAO workplaceSearchPopDAO;
	
	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등) 목록을 조회한다.
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
		
		String gubun = (String) mapParam.get("upjangGubun");
		
		//FMS UPJANG
		if(gubun.equals("FMS")){
			return workplaceSearchPopDAO.selectList(mapParam);			
		//FMS UPJANG2
		}else if(gubun.equals("FMS2")){
			return workplaceSearchPopDAO.selectFmsUpjangList(mapParam);
		
		}else{			
			return workplaceSearchPopDAO.selectList(mapParam);
		}
			
	}	
	
}
