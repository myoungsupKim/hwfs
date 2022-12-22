package com.hwfs.sc.scc.service;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sc.scc.dao.Scc99999pDAO;

/**
 * 진척도관리의 테스트결과서를 등록한다.
 * 
 * @ClassName Scc99999pServiceImpl.java
 * @Description Scc99999pServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 13.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 13.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/Scc99999pService")
public class Scc99999pServiceImpl extends DefaultServiceImpl implements
		Scc99999pService {

	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;

	@Resource(name = "/sc/scc/scc99999pDAO")
	private Scc99999pDAO scc99999pDAO;
	
	/**
	 * 진척도관리의 테스트결과서를 등록한다.
	 * 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 * 
	 * @param list
	 * @param listFile
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scc.service.Scc99999pService#saveAttachFile(hone.online.xplatform.map.DataSetMap,
	 *      hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	public String saveAttachFile(DataSetMap listFile) throws Exception {
		String strRefSeq = ""; // 첨부참조일련번호

		// 첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(listFile,
				propertiesService.getString("sc.file.path") + "/scc", false);

		return strRefSeq;
	}

	/**
	 * PL테스트 조회
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scc.service.Scc99999pService#selectPlTestList(java.util.Map)
	*/
	@Override
	public RecordSet selectPlTestList(Map<String, Object> parameter)
			throws Exception {
		return scc99999pDAO.selectPlTestList(parameter);
	}

	/**
	 * PI테스트 조회
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scc.service.Scc99999pService#selectPiTestList(java.util.Map)
	*/
	@Override
	public RecordSet selectPiTestList(Map<String, Object> parameter)
			throws Exception {
		return scc99999pDAO.selectPiTestList(parameter);
	}

}
