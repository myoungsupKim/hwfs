package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.PersChgDAO;

/**
 * 개인정보를 변경하는 PersChg Service Implementation
 *
 * @ClassName PersChgServiceImpl.java
 * @Description PersChgServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.29
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/persChgService")
public class PersChgServiceImpl extends DefaultServiceImpl implements
		PersChgService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** PersChgDAO Bean 생성 */
	@Resource(name = "/sc/cmn/persChgDAO")
	private PersChgDAO persChgDAO;

	/**
	 * 개인정보 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet select() throws Exception {
		return persChgDAO.select();
	}

	
	public RecordSet selectUserSms(Map<String, Object> parameter) throws Exception {
		return persChgDAO.selectUserSms(parameter);
	}
	/**
	 * 개인정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
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
	public int save(DataSetMap master) throws Exception {
		int updRowCnt = 0;

		Map<String, Object> rowData = master.get(0);
		updRowCnt += persChgDAO.update(rowData);

		return updRowCnt;
	}
}
