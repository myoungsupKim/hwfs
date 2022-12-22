package com.hwfs.ms.msc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.msc.dao.SaniImprovePlanDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 개선계획작성 SaniImprovePlanServiceImpl
 * 
 * @ClassName SaniImprovePlanServiceImpl.java
 * @Description SaniImprovePlanServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.29                최초생성
 * </pre>
 * @author 
 * @since 2022.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/msc/saniImprovePlanService")
public class SaniImprovePlanServiceImpl extends DefaultServiceImpl implements SaniImprovePlanService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	@Resource(name = "/ms/msc/saniImprovePlanDAO")
	private SaniImprovePlanDAO saniImprovePlanDAO;		
	
	/**
	 * 개선계획작성 목록을 조회한다.
	 */
	public RecordSet selectMaster(Map<String, Object> mapParam) throws Exception {
		return saniImprovePlanDAO.selectMaster(mapParam);
	}
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return saniImprovePlanDAO.selectDetail(mapParam);
	}
	
	
	
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap dsDetail,  LoginDTO loginDTO) throws Exception {
		
		int updDetailRowCnt = 0;
		
		for (int i=0; i<dsDetail.size(); i++) {
			Map<String, Object> detailRow =  dsDetail.get(i);
			detailRow.put("sabun", loginDTO.getSabun());

			//System.out.println("detailRow >>>>> " + detailRow);
			updDetailRowCnt += saniImprovePlanDAO.updateList(detailRow);
			
		}

		return updDetailRowCnt;
	}
}
