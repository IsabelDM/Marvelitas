class Modelo{
  String _user;
  String _pwd;
  String _email;

  Modelo(

    {String user, String pwd, String email}
  ){
    this._user = user;
    this._pwd = pwd;
    this._email= email;
  }
  
  String get user =>_user;
  set user(value)=>value;
  String get pwd => _pwd;
  set pwd(value)=> value;
  String get email => _email;
  set email(value)=> value;
}

List<Modelo> usuarios = <Modelo>[
  Modelo(
    user: "JWalters",
    pwd: "Marvel1",
    email: "bestabogadaever@shulkie.com",

  )
];