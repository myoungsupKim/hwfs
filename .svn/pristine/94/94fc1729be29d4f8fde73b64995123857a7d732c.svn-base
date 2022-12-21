package hanwha.neo.branch.common.slo.service;

public class CommonSloWsProxy implements hanwha.neo.branch.common.slo.service.CommonSloWs {
  private String _endpoint = null;
  private hanwha.neo.branch.common.slo.service.CommonSloWs commonSloWs = null;
  
  public CommonSloWsProxy() {
    _initCommonSloWsProxy();
  }
  
  public CommonSloWsProxy(String endpoint) {
    _endpoint = endpoint;
    _initCommonSloWsProxy();
  }
  
  private void _initCommonSloWsProxy() {
    try {
      commonSloWs = (new hanwha.neo.branch.common.slo.service.CommonSloWsImplServiceLocator()).getCommonSloWsImplPort();
      if (commonSloWs != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)commonSloWs)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)commonSloWs)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (commonSloWs != null)
      ((javax.xml.rpc.Stub)commonSloWs)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public hanwha.neo.branch.common.slo.service.CommonSloWs getCommonSloWs() {
    if (commonSloWs == null)
      _initCommonSloWsProxy();
    return commonSloWs;
  }
  
  public hanwha.neo.branch.common.approval.dto.SLO_RESPONSE create(hanwha.neo.branch.common.approval.dto.SLO_REQUEST SLO_REQUEST) throws java.rmi.RemoteException{
    if (commonSloWs == null)
      _initCommonSloWsProxy();
    return commonSloWs.create(SLO_REQUEST);
  }
  
  public hanwha.neo.branch.common.approval.dto.SLO_RESPONSE login(hanwha.neo.branch.common.approval.dto.SLO_REQUEST SLO_REQUEST) throws java.rmi.RemoteException{
    if (commonSloWs == null)
      _initCommonSloWsProxy();
    return commonSloWs.login(SLO_REQUEST);
  }
  
  
}