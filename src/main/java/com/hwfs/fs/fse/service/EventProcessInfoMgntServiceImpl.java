package com.hwfs.fs.fse.service;

import hone.core.util.StringUtils;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.apache.commons.io.FileUtils;

import ch.qos.logback.classic.Logger;

import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.cmn.idgen.UUIdGenService;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.fs.fse.dao.EventProcessInfoMgntDAO;
import com.hwfs.fs.fsm.dao.MachineCodePopDAO;
import com.hwfs.fs.fsm.dao.MachineMstRegDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dao.AttachFileDAO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sc.cmn.util.FileUtil;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 이벤트 진행정보 관리하는 EventProcessInfoMgnt Service Implementation
 *
 * @ClassName EventProcessInfoMgntServiceImpl.java
 * @Description EventProcessInfoMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18    남기빈        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 남기빈
 * @since 2015.03.18
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fse/eventProcessInfoMgntService")
public class EventProcessInfoMgntServiceImpl extends DefaultServiceImpl implements EventProcessInfoMgntService {

    /** EventProcessInfoMgntDAO Bean 생성 */
    @Resource(name = "/fs/fse/eventProcessInfoMgntDAO")
    private EventProcessInfoMgntDAO eventProcessInfoMgntDAO;

    /** AttachFileDAO */
    @Resource(name="/sc/cmn/attachFileDAO")
    private AttachFileDAO attachFileDAO;

    /** CryptoService */
    @Resource(name = "ariaCryptoService")
    protected ARIACryptoServiceImpl cryptoService;

    /** UUIdGenService */
    @Resource(name = "idGenUUIdService")
    protected UUIdGenService idGenUUIdService;

    /** File Attach DB Sequence idGnrService */
    @Resource(name="idGenSequenceAtchFile")
    private SequenceIdGenService idGenSequenceAtchFile;
    
    //주소를 처리하기 위한 공통 Service
  	@Resource(name = "/sc/cmn/addrSearchService")
  	private AddrSearchService addressService;
  	
  	@Resource(name = "/fs/fsm/machineCodePopDAO")
  	private MachineCodePopDAO machineCodePopDAO;
  	
  	/** MachineMstRegDAO Bean 생성 */
	@Resource(name = "/fs/fsm/machineMstRegDAO")
	private MachineMstRegDAO machineMstRegDao;

    /**
     * 이벤트 분류 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectCboList(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectCboList(parameter);
    }

    /**
     * 이벤트 테마 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectThemeList(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectThemeList(parameter);
    }

    /**
     * 이벤트 신청 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectGrdList(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectGrdList(parameter);
    }

    /**
     * 이벤트 대분류 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectLclass(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectLclass(parameter);
    }

    /**
     * 이벤트 중분류 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectMclass(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectMclass(parameter);
    }

    /**
     * 이벤트 소분류 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectSclass(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectSclass(parameter);
    }

    /**
     * 이벤트 Master 정보를 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectEventMst(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectEventMst(parameter);
    }

    /**
     * 이벤트 Master 진행정보를 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectMstProgress(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectMstProgress(parameter);
    }

    /**
     * 이벤트 신청 정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
    */
    @Override
    public RecordSet selectEventReq(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectEventReq(parameter);
    }

    /**
     * 이벤트 진행정보 관리 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectProgress(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectProgress(parameter);
    }

    /**
     * 기기 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
    */
    @Override
    public RecordSet selectInforeg(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectInforeg(parameter);
    }

    /**
     * 사업장 기기 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
    */
    @Override
    public RecordSet selectUpjangutensil(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectUpjangutensil(parameter);
    }

    /**
     * 기기/물류 재고수량을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
    */
    @Override
    public RecordSet selectInventoryQty(Map<String, Object> parameter) throws Exception {
        return machineCodePopDAO.selectPopCodeList(parameter);
    }

    /**
     * 코드 정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    @Override
    public RecordSet selectInforegCode(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectInforegCode(parameter);
    }

    /**
     * 서버 사진을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    @Override
    public RecordSet selectImgList(Map<String, Object> parameter) throws Exception {
        return eventProcessInfoMgntDAO.selectImgList(parameter);
    }

    /**
     * 이벤트 진행정보 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param form
     * @param progress
     * @param inforeg
     * @param utensil
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
    public int saveList(DataSetMap form, DataSetMap progress, DataSetMap inforeg, DataSetMap utensil, DataSetMap file, String sabun) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        String evntId    = "";  //이벤트 id
        String strRefSeq = "";  //첨부참조일련번호
        
        //첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
        if (file.size() > 0) {
            strRefSeq = save(file, propertiesService.getString("fs.file.path"), false);
        }
        
        //이벤트 등록 폼
        if (form.size() > 0) {
            Map<String, Object> rowFormData = form.get(0);
            int rowFormType = ((Integer)rowFormData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            
            //주소 처리
			Map<String, Object> rtn = addressService.setAddress(rowFormData, "addrInfo", sabun);
			
            String signPrcgSabun = LimsUtil.checkNull(rowFormData.get("signPrcgSabun").toString());
            String signStatus    = LimsUtil.checkNull(rowFormData.get("signStatus").toString());

            if (!"".equals(strRefSeq)) {
                rowFormData.put("fileId", strRefSeq);
            }

            if (!"".equals(signPrcgSabun) && "".equals(signStatus)) {
                rowFormData.put("signStatus", "001");
            }

            if(rowFormType == DataSet.ROW_TYPE_DELETED) {                          //Delete 처리
                delRowCnt += eventProcessInfoMgntDAO.deleteForm(rowFormData);
            } else if(rowFormType == DataSet.ROW_TYPE_UPDATED) {                   //Update 처리
                updRowCnt += eventProcessInfoMgntDAO.updateForm(rowFormData);
            } else if(rowFormType == DataSet.ROW_TYPE_INSERTED) {                  //Insert 처리
                RecordSet reMstSeq = eventProcessInfoMgntDAO.selectEvntId(rowFormData);

                evntId = reMstSeq.get(0).getString("evntId");
                rowFormData.put("evntId", evntId);

                insRowCnt += eventProcessInfoMgntDAO.insertForm(rowFormData);
            } else {
                evntId = rowFormData.get("evntId").toString();

                if (!"".equals(strRefSeq)) {
                    updRowCnt += eventProcessInfoMgntDAO.updateForm(rowFormData);
                }
            }
        }

        // 진행절차 등록
        for (int i = 0 ; i < progress.size(); i++) {
            Map<String, Object> rowProgressData = progress.get(i);
            int rowType = ((Integer)rowProgressData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_DELETED) {                                      //Delete 처리.
                delRowCnt += eventProcessInfoMgntDAO.deletePrcdr(rowProgressData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {                               //Update 처리
                updRowCnt += eventProcessInfoMgntDAO.updatePrcdr(rowProgressData);
            } else if (rowType == DataSet.ROW_TYPE_INSERTED) {                              //Insert 처리
                String progressEvntId    = LimsUtil.checkNull(rowProgressData.get("evntId").toString());
                if ("".equals(progressEvntId)) {
                	rowProgressData.put("evntId", evntId);
                }                
                
                insRowCnt += eventProcessInfoMgntDAO.insertPrcdr(rowProgressData);
            }
        }

        //사업장 기기 등록관리
        for (int i = 0 ; i < inforeg.size(); i++) {
      
            Map<String, Object> rowInforegData = inforeg.get(i);
            int rowType = ((Integer)rowInforegData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            
            int residualQty = 0;
            
			//동시 신청 잔여수량 체크
            if(rowType != DataSet.ROW_TYPE_DELETED){
				residualQty = machineMstRegDao.selectMachineMstCnt(rowInforegData);
				if(residualQty < Integer.parseInt(rowInforegData.get("requestQuantity").toString())) return -1;
            }
		
            if (rowType == DataSet.ROW_TYPE_DELETED) {                                      //Delete 처리.
                delRowCnt += eventProcessInfoMgntDAO.deleteInforeg(rowInforegData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {                               //Update 처리
                updRowCnt += eventProcessInfoMgntDAO.updateInforeg(rowInforegData);
            } else if (rowType == DataSet.ROW_TYPE_INSERTED) {                              //Insert 처리
                if (!"".equals(evntId)) {
                	rowInforegData.put("evntId", evntId);
                }         
                insRowCnt += eventProcessInfoMgntDAO.insertInforeg(rowInforegData);
            }
        }

        //기기/포장제 등록관리
        for (int i = 0 ; i < utensil.size(); i++) {
            Map<String, Object> rowUtensilData = utensil.get(i);
            int rowType = ((Integer)rowUtensilData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_DELETED) {                                      //Delete 처리.
                delRowCnt += eventProcessInfoMgntDAO.deleteUpjangutensil(rowUtensilData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {                               //Update 처리
                updRowCnt += eventProcessInfoMgntDAO.updateUpjangutensil(rowUtensilData);
            } else if (rowType == DataSet.ROW_TYPE_INSERTED) {                              //Insert 처리
                rowUtensilData.put("evntId", evntId);

                insRowCnt += eventProcessInfoMgntDAO.insertUpjangutensil(rowUtensilData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 global.filerepository.path가 된다.
     * </pre>
     *
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미)
     * @throws Exception
     */
    public String save(DataSetMap listFile, String relPath, boolean encYn) throws Exception {
        return save(listFile, relPath, encYn, false, false);
    }

    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 webRepoYn가 true이면 global.imagerepository.path, false이면 global.filerepository.path가 된다.
     * - useOrgnlNmYn가 true이면 원본 파일명을 유지
     * </pre>
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @param webRepoYn 파일저장소를 webapp 아래로 할지 여부(true이면 global.imagerepository.path 아래로 저장)
     * @param useOrgnlNmYn 파일저장 시 원본 파일명을 유지할지 여부 (보안에 문제가 없는 파일인 경우만 원본명 유지 가능)
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String save(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn, boolean useOrgnlNmYn) throws Exception {

        String strRefSeq = ""; //첨부일련번호

        //첨부일련번호를 얻는다.
        for (int i = 0; i < listFile.size(); i++) {
            Map<String, Object> map = listFile.get(i);
            int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType != DataSet.ROW_TYPE_INSERTED) { //ROW_TYPE_UPDATED || rowType == DataSet.ROW_TYPE_DELETED){
                strRefSeq =  map.get("refSeq").toString(); //Long.parseLong(map.get("refSeq").toString());
                break;
            }
        }
        //첨부일련번호를 새로 채번하는 경우 처리
        if (strRefSeq.equals(""))
            strRefSeq = idGenSequenceAtchFile.getNextStringId();

        int intCnt=0;   //파일 처리 건수

        //먼저 첨부파일 처리
        for (int i = 0; i < listFile.size(); i++) {
            Map<String, Object> map = listFile.get(i);

            int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if ( rowType == DataSet.ROW_TYPE_INSERTED ){
                //첨부일련번호 설정
                map.put("refSeq", strRefSeq);

                //저장시 원본파일명 유지 여부에 따라 처리
                if (!useOrgnlNmYn) {
                    //저장파일명 설정 - UUID 적용 및 시간표시
                    if (propertiesService.getBoolean("global.fileupload.appendTime"))
                        map.put("saveFileNm", idGenUUIdService.getNextStringHostId() + "-" + DateUtil.getYyyymmddhhmmss());
                    else
                        map.put("saveFileNm", idGenUUIdService.getNextStringHostId());
                }else{
                    map.put("saveFileNm", DateUtil.getYyyymmddhhmmss() + "-" + map.get("orgnlFileNm"));
                }
                //저장상대패스 설정
                map.put("relPath", relPath);

                //파일암호화 여부
                map.put("encYn", encYn ? "Y" : "N");

                //DAO 호출
                intCnt += attachFileDAO.insert(map);

                //파일저장소로 복사
                String sourceFile = propertiesService.getString("global.fileupload.path") + "/" + map.get("fileUploadNm");
                String targetFile;
                if (webRepoYn)
                    targetFile = propertiesService.getString("global.imagerepository.path") + relPath + "/" + map.get("saveFileNm");
                else
                    targetFile = propertiesService.getString("global.filerepository.path") + relPath + "/" + map.get("saveFileNm");

                //-파일암호화 처리
                if (encYn) {
                    String encFile = sourceFile + "_enc";
                    cryptoService.encryptFile(sourceFile, encFile);
                    sourceFile = encFile;
                }

                boolean isCopied = false;

                if (!"".equals(LimsUtil.checkNull(map.get("preView")))) {
                    String dirFrom = propertiesService.getString("global.imagerepository.path") + "/" + propertiesService.getString("ms.file.path");
                    String preView = LimsUtil.checkNull(map.get("preView").toString());
                    File   preFile = new File(dirFrom + preView);
                    //파일 이동처리
                    FileUtils.copyFile(preFile, new File(targetFile));
                    if(preFile.isFile()) {
                        isCopied = true;
                    }
                } else {
                    //파일 이동처리
                    isCopied = FileUtil.copyFile (sourceFile, targetFile);
                }

                if (!isCopied)
                    throw super.processException("fail.uploadfile.not.found");

            } else if (rowType == DataSet.ROW_TYPE_UPDATED){
                intCnt += attachFileDAO.update(map);
            } else if (rowType == DataSet.ROW_TYPE_DELETED){
                intCnt += attachFileDAO.delete(map);
                //파일저장소 파일 삭제
                String targetFile;
                if (webRepoYn)
                    targetFile = propertiesService.getString("global.imagerepository.path") + map.get("relPath") + "/" + map.get("saveFileNm");
                else
                    targetFile = propertiesService.getString("global.filerepository.path") + map.get("relPath") + "/" + map.get("saveFileNm");
                FileUtil.deleteFile(targetFile);
            }
        }

        //새로 채번된 참조일련번호 (-1 이면 변경되지 않음을 의미)
        if (intCnt == 0)
            return "";
        else
            return strRefSeq;
    }
}