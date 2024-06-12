class Role{
  String id='';
  String name='';


  //Role({constructor});

  Map toMapAll(){
    return {'id':this.id,'name':this.name};
  }

  Map toMapStore(){
    return {'name':this.name};
  }

}