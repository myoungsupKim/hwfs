package com.hwfs.fs.fsl.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsl.dao.UpjangNonSaleDayInqDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 사업장기준정보 저장권한 관리 UpjangNonSaleDayInqServiceImpl Service Implementation
 * 
 * @ClassName UpjangNonSaleDayInqServiceImpl.java
 * @Description UpjangNonSaleDayInqServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2020.04.07    이필승        최초생성
 * </pre>
 * @author 한화시스템/ICT : 이필승
 * @since 2020.04.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2019 by HANWHA CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsl/upjangNonSaleDayInqService")
public class UpjangNonSaleDayInqServiceImpl extends DefaultServiceImpl implements UpjangNonSaleDayInqService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** UpjangNonSaleDayInqDAO Bean 생성 */
	@Resource(name = "/fs/fsl/upjangNonSaleDayInqDAO")
	private UpjangNonSaleDayInqDAO upjangNonSaleDayInqDAO;
	
	
	/**
	 * 업장 기준정보 권한 목록 조회
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
		return upjangNonSaleDayInqDAO.selectList(mapParam);
	}
	
}
