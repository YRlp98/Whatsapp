class ChatModel {
  final int id;
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  ChatModel({this.id, this.name, this.message, this.time, this.avatarUrl});
}

List<ChatModel> dummyData = [
  ChatModel(
      name: 'Yousef Roshandel',
      message: 'سلام :|',
      time: '05:05',
      avatarUrl:
          'https://lh6.googleusercontent.com/-HOemVlYejDk/AAAAAAAAAAI/AAAAAAAAF44/aCzKo-Ta66E/photo.jpg?sz=200'),
  ChatModel(
      name: 'Sembele Ghoz',
      message: 'اوه!',
      time: '04:04',
      avatarUrl:
          'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/3d/3d2219d9644f01e9c52b0959d13771b9f029a411_full.jpg'),
  ChatModel(
    name: 'Yasser Roshandel',
    message: '123',
    time: '04:03',
    avatarUrl:
        'https://scontent-lhr3-1.cdninstagram.com/vp/da4516e0f4f1d372fa062fe7c3a1ac6d/5D3FD951/t51.2885-19/s150x150/52097303_363194517856880_3242228167020118016_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com',
  ),
  ChatModel(
    name: 'Arash Barahmand',
    message: 'سلام D:',
    time: '03:03',
    avatarUrl:
        'https://scontent-lhr3-1.cdninstagram.com/vp/9195f483a144eab4e96ead06b9a659aa/5D52E4BA/t51.2885-19/s150x150/25012105_316582132179828_4185443383684104192_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com',
  ),
  ChatModel(
    name: 'Aref Mozafari',
    message: 'حسش نیست داداش :(',
    time: '03:03',
    avatarUrl:
        'https://scontent-lhr3-1.cdninstagram.com/vp/93aa9dcad33b7b1401d683d1bfff5a39/5D406507/t51.2885-19/s150x150/52365810_1202344736588670_5595286237050044416_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com',
  ),
  ChatModel(
    name: 'Agha Mahdi',
    message: 'آقا یوسف',
    time: '03:03',
    avatarUrl:
        'https://scontent-lhr3-1.cdninstagram.com/vp/e4bca73c4f38cfabd9f0c1cc31e560a3/5D6B05EC/t51.2885-19/s150x150/53262163_411910702691111_5206849381914902528_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com',
  ),
  ChatModel(
    name: 'Sadra Makhmali (Lashi)',
    message: 'پول مارو بده لاشی!',
    time: '03:03',
    avatarUrl:
        'https://scontent-lhr3-1.cdninstagram.com/vp/a9c92f2bc0ca869989b951a651157ed0/5D54139F/t51.2885-19/s150x150/15535265_426617081060673_7313927966163992576_a.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com',
  ),
  ChatModel(
    name: 'Masoud Yousefnejad',
    message: 'احسنت!',
    time: '03:03',
    avatarUrl:
        'https://scontent-lhr3-1.cdninstagram.com/vp/bafda16b23995ec8a46b13817d7fd2e0/5D3E9368/t51.2885-19/s150x150/14730690_638269519679701_964862796728631296_a.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com',
  ),
  ChatModel(
    name: 'Morteza Gholami',
    message: ':D',
    time: '02:02',
    avatarUrl:
        'https://scontent-lhr3-1.cdninstagram.com/vp/cd863fd9d0dedc1b8b8485c6bf11b691/5D6BDFE9/t51.2885-19/s150x150/50622487_372990406815500_8530181550984134656_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com',
  ),
  ChatModel(
    name: 'MD LUTFOR RAHMAN',
    message: 'Khelo from Bangladesh!',
    time: '01:01',
    avatarUrl:
        'https://scontent-lhr3-1.cdninstagram.com/vp/7ea23d83050bc598b762a7cd03ae5e86/5D3B295F/t51.2885-19/s150x150/23498876_1933100103675579_1551689890687614976_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com',
  ),
];
