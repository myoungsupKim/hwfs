package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.roa.dao.PartTimebyUpjangDAO;

 /**
 * 업장별 용역 발생 내역을 관리하는 PartTimebyUpjang Service Implementation
 * 
 * @ClassName PartTimebyUpjangServiceImpl.java
 * @Description PartTimebyUpjangServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.23    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/roa/partTimebyUpjangService")
public class PartTimebyUpjangServiceImpl extends DefaultServiceImpl implements PartTimebyUpjangService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** PartTimebyUpjangDAO Bean 생성 */
	@Resource(name = "/rc/roa/partTimebyUpjangDAO")
	private PartTimebyUpjangDAO partTimebyUpjangDAO;
	

	/**
	 * 업장별 용역 발생 내역 목록을 조회한다.
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
		return partTimebyUpjangDAO.selectList(mapParam);
	}

}
