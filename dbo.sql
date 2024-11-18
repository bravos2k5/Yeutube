/*
 Navicat Premium Dump SQL

 Source Server         : asm
 Source Server Type    : SQL Server
 Source Server Version : 16001135 (16.00.1135)
 Source Host           : localhost:1433
 Source Catalog        : yeutube
 Source Schema         : dbo

 Target Server Type    : SQL Server
 Target Server Version : 16001135 (16.00.1135)
 File Encoding         : 65001

 Date: 15/11/2024 08:14:33
*/


-- ----------------------------
-- Table structure for Favourite
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Favourite]') AND type IN ('U'))
	DROP TABLE [dbo].[Favourite]
GO

CREATE TABLE [dbo].[Favourite] (
  [id] bigint  NOT NULL,
  [likedDate] datetime2(7)  NULL,
  [userId] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [videoId] uniqueidentifier  NULL
)
GO

ALTER TABLE [dbo].[Favourite] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Favourite
-- ----------------------------
INSERT INTO [dbo].[Favourite] ([id], [likedDate], [userId], [videoId]) VALUES (N'1', N'2024-11-13 08:47:20.0000000', N'admin', N'26E2AAFE-1758-4F6F-BF24-18B08900DEA9')
GO

INSERT INTO [dbo].[Favourite] ([id], [likedDate], [userId], [videoId]) VALUES (N'2', N'2024-11-13 08:48:12.0000000', N'admin', N'E9130626-CEEF-47F0-8D63-1C53847E4828')
GO

INSERT INTO [dbo].[Favourite] ([id], [likedDate], [userId], [videoId]) VALUES (N'3', N'2024-11-13 08:48:35.0000000', N'admin', N'065BB2E6-C0B7-449F-95F3-2AB29D26EDD6')
GO

INSERT INTO [dbo].[Favourite] ([id], [likedDate], [userId], [videoId]) VALUES (N'4', N'2024-11-13 08:48:57.0000000', N'admin', N'B99552FE-59D7-4A79-B563-40A7743E6A91')
GO

INSERT INTO [dbo].[Favourite] ([id], [likedDate], [userId], [videoId]) VALUES (N'5', N'2024-11-13 08:49:18.0000000', N'baotphcm1612', N'6538F4CB-CD74-4C9E-BF27-59D643F67ABE')
GO

INSERT INTO [dbo].[Favourite] ([id], [likedDate], [userId], [videoId]) VALUES (N'6', N'2024-11-13 08:49:41.0000000', N'baotphcm1612', N'382B4CE7-D3C1-4D00-9163-6F263325EF2D')
GO

INSERT INTO [dbo].[Favourite] ([id], [likedDate], [userId], [videoId]) VALUES (N'7', N'2024-11-13 08:50:14.0000000', N'baotphcm1612', N'5FA750D5-1585-4499-8FC6-84B4C0231C98')
GO

INSERT INTO [dbo].[Favourite] ([id], [likedDate], [userId], [videoId]) VALUES (N'8', N'2024-11-13 08:50:28.0000000', N'test005', N'4CEBEEBC-9A76-452A-85FE-97E78A26FFDA')
GO

INSERT INTO [dbo].[Favourite] ([id], [likedDate], [userId], [videoId]) VALUES (N'9', N'2024-11-13 08:50:52.0000000', N'test005', N'22570FE1-3660-490A-A6BE-AADA53848719')
GO


-- ----------------------------
-- Table structure for Share
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Share]') AND type IN ('U'))
	DROP TABLE [dbo].[Share]
GO

CREATE TABLE [dbo].[Share] (
  [id] bigint  NOT NULL,
  [email] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [sharedDate] datetime2(7)  NULL,
  [userId] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [videoId] uniqueidentifier  NULL
)
GO

ALTER TABLE [dbo].[Share] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Share
-- ----------------------------
INSERT INTO [dbo].[Share] ([id], [email], [sharedDate], [userId], [videoId]) VALUES (N'1', N'nationalbao2005@gmail.com', N'2024-11-14 22:42:53.8570000', N'test005', N'E9130626-CEEF-47F0-8D63-1C53847E4828')
GO


-- ----------------------------
-- Table structure for Users
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type IN ('U'))
	DROP TABLE [dbo].[Users]
GO

CREATE TABLE [dbo].[Users] (
  [id] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [admin] bit DEFAULT 0 NOT NULL,
  [email] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [fullName] nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [password] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[Users] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Users
-- ----------------------------
INSERT INTO [dbo].[Users] ([id], [admin], [email], [fullName], [password]) VALUES (N'admin', N'1', N'nationalbao2005@gmail.com', N'Admin', N'$2a$12$ZuBjUAq6CwsbQL9ijiiGK.3uGj3f833me3wX3EhFSoQZGfFNKH0D6')
GO

INSERT INTO [dbo].[Users] ([id], [admin], [email], [fullName], [password]) VALUES (N'baotphcm1612', N'0', N'nationalbao2005@gmail.com', N'Nguyen Quoc Bao', N'$2a$10$HsX2vAsY3MDQN7ilucHOLuduYREUWDHjhv19itOn3uNWQIutiocKK')
GO

INSERT INTO [dbo].[Users] ([id], [admin], [email], [fullName], [password]) VALUES (N'test0', N'0', N'nationalbao2005@gmail.com', N'Nguyen Van CA', N'$2a$10$GOeMrnr1GnJ3zcyqLJAebOD1MLieqvGh./7wVG769S6biBTEq/wQ2')
GO

INSERT INTO [dbo].[Users] ([id], [admin], [email], [fullName], [password]) VALUES (N'test005', N'0', N'baonqps41272@gmail.com', N'Songoku', N'$2a$10$l6xNKIEwAErRykpyZoolHe0SjPqKSJmgMbjCeqV0CQ7BtxtG61Goy')
GO

INSERT INTO [dbo].[Users] ([id], [admin], [email], [fullName], [password]) VALUES (N'test01', N'0', N'nationalbao2005@gmail.com', N'Vegeta', N'$2a$10$Fw6JvNCWoiUa4TsdRyQtOu8cufaewqU.ho5HBjcq7lQGBXucUKzZm')
GO

INSERT INTO [dbo].[Users] ([id], [admin], [email], [fullName], [password]) VALUES (N'test123', N'0', N'nationalbao2005@gmail.com', N'Quoc Beo', N'$2a$10$YKMm1JC6GvhVvdP9FYcOKuSzviugtp/MisVtYt26rN15LOXM3xzSS')
GO


-- ----------------------------
-- Table structure for Video
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Video]') AND type IN ('U'))
	DROP TABLE [dbo].[Video]
GO

CREATE TABLE [dbo].[Video] (
  [id] uniqueidentifier  NOT NULL,
  [active] bit  NULL,
  [createdTime] datetime2(7)  NULL,
  [description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [poster] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [title] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [views] bigint DEFAULT 0 NULL,
  [youtubeId] varchar(11) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[Video] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Video
-- ----------------------------
INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'26E2AAFE-1758-4F6F-BF24-18B08900DEA9', N'1', N'2024-11-05 07:25:04.6298443', N'Light Switch out now!
Download/stream: https://charlieputh.lnk.to/LightSwitchID

Text: (323) 524-9978

Subscribe for more official content from Charlie Puth:
https://Atlantic.lnk.to/CPsubscribeID

Follow Charlie
http://charlieputh.com 
http://twitter.com/charlieputh 
http://facebook.com/charlieputh 
http://instagram.com/charlieputh
https://soundcloud.com/charlieputh
https://www.tiktok.com/@charlieputh
https://my.community.com/charlieputh

Lyrics:
Yeah, 
Why you callin’ at 11:30
When you only wanna do me dirty 
But I hit right back ‘cause you got that that, yeah 

Why you always wanna act like lovers 
But you never wanna be each other’s 
I say don’t look back but I go right back and

All the sudden I’m hypnotized 
You’re the one that I can’t deny 
Every time that I say I’m gonna walk away 

You turn me on like a light switch 
When your moving your body around and around
Now I don’t wanna fight this (No) 
You know how to just make me want you 
turn me on like a light switch 
When your moving your body around and around
You got me in a tight grip (Yeah)
You know how to just make me want you, baby 

Do you love it when you keep me guessing?
When you leave and then you leave me stressing?
But I cant stay mad when you walk like that, no

Why you always wanna act like lovers 
But you never wanna be each other’s
I say don’t look back but I go right back and

All a sudden I’m hypnotized 
You’re the one that I can’t deny 
Every time that I say I’m gonna walk away 

You turn me on like a light switch 
When your movin’ your body around and around
No, I don’t wanna fight this (No) 
You know how to just make me want you 
You turn me on like a light switch (Switch) 
When your movin’ your body around and around
You got me in a tight grip (Grip)
You know how to just make me want you, baby 

C’mon, C’mon, C’mon, C’mon, C’mon and show me how you do (Do)
You want, you want, you want, you want, you want me to keep wantin’ you (wantin’ you girl)
C’mon, C’mon, C’mon, C’mon, C’mon and show me how you do (How you do)
You want, you want, you want, you want, you want me to keep wantin’ you

You turn me on like a light switch 
When your movin’ your body around and around
No, I don’t wanna fight this 
You know how to just make me want to 
You turn me on like a light switch 
When your movin’ your body around and around
You got me in a tight grip 
You know how to just make me want you, baby 

C’mon, C’mon, C’mon, C’mon, C’mon and show me how you do 
You want, you want, you want, you want, you want me to keep wantin’ you 
C’mon, C’mon, C’mon, C’mon, C’mon and show me how you do 
You want, you want, you want, you want, you want me to keep wantin’ you

The official YouTube channel of Atlantic Records artist Charlie Puth. Subscribe for the latest music videos, performances, and more.

#CharliePuth #LightSwitch #MusicVideo', N'https://i.ytimg.com/vi/WFsAon_TWPQ/maxresdefault.jpg', N'Charlie Puth - Light Switch [Official Music Video]', N'6', N'WFsAon_TWPQ')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'E9130626-CEEF-47F0-8D63-1C53847E4828', N'1', N'2024-11-05 07:25:04.8333788', N'Hãy cùng thưởng thức ca khúc ĐỪNG LÀM TRÁI TIM ANH ĐAU ngay tại đây nhé: 👉🏻 👉🏻 👉🏻  https://vivienm.lnk.to/DLTTAD 💍❤️‍🩹🧩

#DLTTAD #SonTungMTP #DungLamTraiTimAnhDau 

🚫🤲🏻♥️🙆🏻‍♂️😢

▶ More information about Sơn Tùng M-TP: 
https://www.facebook.com/MTP.Fan
https://www.instagram.com/sontungmtp
https://www.youtube.com/sontungmtp
https://www.tiktok.com/@tiger050794 
https://twitter.com/sontungmtp777
@Spotify: https://spoti.fi/2HPWs20
@Itunes: https://apple.co/2rlSl3w

▶More information about M-TP Talent:
https://www.facebook.com/mtptalent
https://www.instagram.com/mtptalent
https://twitter.com/mtptalent

▶ More about M-TP ENTERTAINMENT
https://www.facebook.com/mtptown
https://mtpentertainment.com 
https://twitter.com/mtpent_official
https://www.instagram.com/mtpent_official

▶ CLICK TO SUBSCRIBE:  http://popsww.com/sontungmtp
#sontungmtp #sontung #mtp #mtpentertainment', N'https://i.ytimg.com/vi/abPmZCZZrFA/maxresdefault.jpg', N'SƠN TÙNG M-TP | ĐỪNG LÀM TRÁI TIM ANH ĐAU | OFFICIAL MUSIC VIDEO', N'54', N'abPmZCZZrFA')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'065BB2E6-C0B7-449F-95F3-2AB29D26EDD6', N'1', N'2024-11-05 07:25:01.4562543', N'Tham gia làm hội viên của kênh này để được hưởng đặc quyền:
https://www.youtube.com/channel/UCky92hx0lZxVBi2BJ6Zm2Hg/join

👉 Link khóa học backend Go: https://www.youtube.com/playlist?list=PLw0w5s5b9NK6qiL9Xzki-mGbq_V8dBQkY

👉 Link khóa học backend Nodejs: https://www.youtube.com/playlist?list=PLw0w5s5b9NK4ucXizOF-eKAXKvn9ruCw8

👉 Link khóa học backend Java: https://www.youtube.com/channel/UCky92hx0lZxVBi2BJ6Zm2Hg/join
Timeline:
03:41 Truy vấn phụ là gì? Cú pháp?
07:49 Xem xét 4 loại truy vấn phụ 
20:45 Bài toán xem xét truy vấn nào chạy trước?
26:30 Trình tối ưu hoá MYSQL thông minh cỡ nào?

🚩  Subscribe  ➜https://www.youtube.com/c/TipsJavascript
#anonystick #mysql #database 
✅  Follow Me:
Blog: https://anonystick.com
Github: https://github.com/anonystick/anonystick
Facebook: https://www.facebook.com/TipJS/
Youtube: https://www.youtube.com/c/TipsJavascript', N'https://i.ytimg.com/vi/ls6vJLO4otA/maxresdefault.jpg', N'Database Backend: Nếu bạn cảm thấy TRUY VẤN CHẬM, xem tối ưu hoá MYSQL thông minh cỡ nào?', N'4', N'ls6vJLO4otA')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'B39AC35E-F7FB-4B7A-BB3B-331911FB19C3', N'1', N'2024-11-05 00:18:30.0572496', N'#wn #267 #id072019 
PRODUCT BY W-NATION
Sáng tác & Prod : W/n 
Executive Producer : Nguyễn Quý Cao Nguyên
Director : 24
ARTIST : W/n , 267
Creative director : 24
art Director : 24 & 44 

Ft rap: nâu


http://UMVN.lnk.to/id072019
#wn #3107 #267 #id072019
#31075 #coconmuanaodoiminhdiqua

More information about W/n : 
https://www.facebook.com/winhmm
https://www.instagram.com/winhmm/
https://www.tiktok.com/@winhmm

More information about 267 :
https://www.facebook.com/titietien
https://www.instagram.com/tie267_/
https://www.tiktok.com/@_tie267

More information about W nation :
https://www.facebook.com/wnation.official/
https://www.instagram.com/wnation.official/

More information about Fanclub W/n''s UFO
https://www.facebook.com/groups/1406675436372939/
https://www.facebook.com/Wn.UFO

lyrics
Có cơn mưa nào đôi mình đi qua
Anh đến bên em ngày đôi mình chia xa
Mùa lá rơi bên hồ
Nỗi cô đơn lớn lên
Mùa thu ấy em không còn bên cạnh anh nữa
Anh vẫn đứng nơi đây chờ em cùng cơn mưa
Chúng ta sau này
Chẳng có chúng ta bây giờ
Một người âm thầm đứng dưới mưa nhìn em
Một người giữa thành phố vẫn cứ chờ em
Vì sao cứ nơi đó mà
Ánh dương giơ nơi đâu?
Giờ này chỉ nỗi nhớ cứ mãi nhiều thêm
Giờ này chỉ mình ta với những tháng năm dài
Có khi em chẳng còn yêu anh
Như trái tim ta từng chung lối đi

Rap:

Anh đi một vòng thị trấn
Trên con đường cũ ta đi
Vòng bánh xe như thế cứ chạy
Hai tuyến đường ngược chiều ta nghĩ
Chắc em cũng quên tên đường này rồi
Nhánh hoa sữa nhẹ bay đi khắp lối
Em cũng giống như anh của ngày trước
Hai con đường về nhà khi sắp tối
Anh còn nhớ hồi đó ta đi học
Lúc tan trường thì em ngồi sau xe
Lúc em buồn thì anh hay trêu chọc
Bảo em cười thì chuyện cho nhau nghe
Rồi vào quán mua món mà em thích
Em mỉm cười làm anh cũng vui lây
Nhưng hồi đó thì vẫn là hồi đó
Anh cảm ơn em đã để lại chuỗi ngày
Một người âm thầm đứng dưới mưa nhìn em
Một người giữa thành phố vẫn cứ chờ em
Vì sao cứ nơi đó mà
Ánh dương giơ nơi đâu?
Giờ này chỉ nỗi nhớ cứ mãi nhiều thêm
Giờ này chỉ mình ta với những tháng năm dài 
Có khi em chẳng còn yêu anh
Như trái tim ta từng chung lối đi

Có cơn mưa nào đôi mình đi qua
Anh viết cho em bài ca mùa yêu xa
Mùa lá rơi bên hồ nỗi cô đơn lớn lên
Mùa thu ấy
Anh không còn bên cạnh em nữa
Em vẫn đứng nơi đây chờ anh cùng cơn mưa
Chúng ta sau này chẳng có chúng ta bây giờ



🎹🎧🎵

Contact my manager : ctwhmm@gmail.com 
--
© Bản quyền thuộc về W/n
© Copyright by W/n ☞ Do not Reup', N'https://i.ytimg.com/vi/leJb3VhQCrg/maxresdefault.jpg', N'W/n - id 072019 | 3107 ft 267', N'17', N'leJb3VhQCrg')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'B99552FE-59D7-4A79-B563-40A7743E6A91', N'1', N'2024-11-05 07:25:02.0820102', N'#tranquochuy 
Mục tiêu: Đừng để tâm trạng tự ti và cảm giác thấp kém làm chủ bản thân bạn, bởi chính những suy nghĩ ấy đang chỉ dẫn bạn đến một bước ngoặt quan trọng. Hãy nhìn nhận chúng như là dấu hiệu ban đầu của quá trình chuyển mình, một dấu hiệu cho thấy bạn đang trên đường tiến tới một sự thay đổi lớn lao và đột phá trong cuộc sống hay sự nghiệp của mình

Ghi chú: Nếu bạn là một lập trình viên và muốn phát triển sự nghiệp một cách nhanh chóng hơn. 

Tôi có một khoá học có thể giúp bạn phát triển rất nhanh (tôi có chiến lược khác biệt dành cho bạn, tôi có 1 liên minh để cùng nhau phát triển sự nghiệp và cả những kỹ năng chuyên môn được đúc kết từ hơn 10 năm trực tiếp tối ưu các dự án quan trọng như Core banking, Core chứng khoán)

Bạn có thể đặt lịch để trực tiếp trải nghiệm khoá học của tôi. Trong buổi trải nghiệm này bạn sẽ WOW vì chiến lược và cách thức mà tôi đã giúp rất nhiều anh em lập trình viên đột phát trong sự nghiệp

Xem chi tiết khoá học của tôi ở đây: https://wecommit.com.vn/tu-dien-toi-uu-100x-hieu-nang/

Bạn có thể xem các dự án mà tôi đã trực tiếp thực hiện tại đây: https://wecommit.com.vn/du-an/

🎯 Một số Video khác bạn có thể xem 
- Bí mật TOP 1% những lập trình viên giỏi nhất | Trần Quốc Huy Wecommit :https://youtu.be/OG5-tV7CHec
- Thiết kế hệ thống Search Engine xử lý 100 tỷ Web Page (Google, Bing...)  | System Design Wecommit:
https://youtu.be/ihp2twFPfG4
- Cách Quora thiết kế cơ sở dữ liệu để đáp ứng 400 triệu người dùng: https://www.youtube.com/watch?v=5z5_fMQn4Tc
- Bí quyết tìm lái xe của Uber: https://www.youtube.com/watch?v=jRdwy9LNSCw
- Hiểu toàn bộ kiến thức về PostgreSQL trong 1h30 phút: https://www.youtube.com/watch?v=OUlLQK_gN8k
- Học SQL Server trong 60 phút : https://www.youtube.com/watch?v=alqEF4I23nw
- Học MongoDB trọn vẹn trong 1 giờ 30 phút: https://www.youtube.com/watch?v=8Nx7cdwT86c
- Tìm hiểu về Vector Database - loại Database giúp Generative AI bùng nổ: https://www.youtube.com/watch?v=qslGfiM67dE

📱 Nếu bạn muốn liên hệ với tôi:
Zalo: 0888549190
Linkedin: https://www.linkedin.com/in/huytq/
Facebook: https://www.facebook.com/tranquochuy.toiuu

#hoclaptrinh #họclậptrình #laptrinhvien  #wecommit #huongdanhoclaptrinh
#vloglaptrinh #toiuucosodulieu #toiuusql #toiuu100x #laptrinhpython #laptrinhjava #laptrinhcnc #laptrinhweb #laptrinhc #developer #devops #fullstacksoftwareengineering #softwareengineer #softwaredeveloper #softwaredevelopment', N'https://i.ytimg.com/vi/WASADesNbVM/maxresdefault.jpg', N'Lập trình viên nghĩ mình KÉM CỎI - dấu hiệu đầu tiên bạn sắp đột phá | Trần Quốc Huy Wecommit', N'0', N'WASADesNbVM')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'57CC8D6C-243B-4708-BA41-44C1D6E71187', N'1', N'2024-11-05 07:25:02.9124139', N'Charlie Puth - One Call Away [Official Video]
From Charlie''s debut album Nine Track Mind!
Download/Stream: https://Atlantic.lnk.to/NineTrackMindID 

Exclusive Nine Track Mind Bundles Available Here: http://smarturl.it/NTMBundlesYT

Light Switch out now!
Download/stream: https://charlieputh.lnk.to/LightSwitchID

Subscribe for more official content from Charlie Puth:
https://Atlantic.lnk.to/CPsubscribeID

Follow Charlie
http://charlieputh.com 
http://twitter.com/charlieputh 
http://facebook.com/charlieputh 
http://instagram.com/charlieputh
https://soundcloud.com/charlieputh
https://www.tiktok.com/@charlieputh

The official YouTube channel of Atlantic Records artist Charlie Puth. Subscribe for the latest music videos, performances, and more.

#CharliePuth #OneCallAway #MusicVideo', N'https://i.ytimg.com/vi/BxuY9FET9Y4/sddefault.jpg', N'Charlie Puth - One Call Away [Official Video]', N'0', N'BxuY9FET9Y4')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'42A9313E-78A8-48F2-B3B9-499B52402ED1', N'1', N'2024-11-05 00:18:29.5042827', N'Composer : Andiez
Guitarist : Việt Dương
Instrumental : Andiez
Record at : LAB studio

Đã bao lâu, lòng này anh chẳng nói 
Nói với em, ngàn lời anh cất giữ trong tim 
Lần này đến lần khác, đôi môi cứ lãng phí chẳng nói gì 
Chỉ biết cạnh em, dù cho em chẳng để ý 

Và rồi em đã có người em yêu 
Mỉm cười cho qua hết đi 
Phải chăng là do người đến sau, yêu em thật nhiều 
Đã nói thay anh những lời anh mong ước 

Vẫn chúc cho em thật vui, mặc anh bên lề của hạnh phúc 
Những phút giây ta đã qua, anh sẽ giữ như thước phim 
Để khi nhớ em anh xem và ước rằng thực tế sẽ như vậy 
Ở nơi đó thời gian như ngừng trôi, hỡi em 

1 phút đứng trước mặt em, 1 phút nói ra lời chưa nói 
1 phút mạnh mẽ từ anh, ta vẫn sẽ chung lối đi 
Anh chẳng thể nào quay lại, để bây giờ chẳng nói giá như 
Giá như em hiểu rằng, giá như em 1 lần nhìn được, từ ánh mắt anh ! 

Vì trái tim anh cần em, vì với anh em là duy nhất 
Thế nhưng bây giờ đây, chẳng thể đến được với nhau 
Anh đã sai thật rồi, anh sai thật rồi 
Vì cứ mãi giữ lời yêu em trong trái tim

————————————
☞ SUBSCRIBE Youtube Andiez:  http://bit.ly/andiezofficial
————————————

More about Andiez
☞ Fanpage: https://www.facebook.com/andiezmusic/
☞ Facebook:https://www.facebook.com/andiez95
☞ Instagram: https://www.instagram.com/1m82.5/

————————————

© Bản quyền thuộc về Andiez
© Copyright by Andiez - Do not Reup', N'https://i.ytimg.com/vi/dLQe4qEfVJw/maxresdefault.jpg', N'1 Phút - Andiez', N'0', N'dLQe4qEfVJw')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'51393582-C3B4-49FA-9846-531C7202BE1B', N'1', N'2024-11-05 00:18:28.0965059', N'Nhạc Lofi Chill Top Xu Hướng 2024 Triệu View ♬ Nắng Có Mang Em Về, Nợ Ai Đó Lời Xin Lỗi, Mây
Nhạc Lofi Chill Top Xu Hướng 2024 Triệu View ♬ Nắng Có Mang Em Về, Nợ Ai Đó Lời Xin Lỗi, Mây
Nhạc Lofi Chill Top Xu Hướng 2024 Triệu View ♬ Nắng Có Mang Em Về, Nợ Ai Đó Lời Xin Lỗi, Mây
#nhaclofi #nhaclofichill #dieunhienlofi 
------------------------------------------------------------------------------------
Lắng Nghe Sản Phẩm Âm Nhạc của bạn "Hoàng Hạo" tại đây nghen: 
1. https://youtu.be/jaF4zMfSNws?si=t2_7Jg6FKQoQsos6
2. https://youtu.be/SPA_JMg9D-8?si=zW3Rqdk6YVGOswW9
♪ TRACKLIST:
00:00 Nắng có mang em về
04:35 Mây
09:47 Hẹn em ở lần yêu thứ 2
15:58 Ngày nắng có em
19:40 Anh thề đấy
23:39 Umee
26:39 Nợ ai đó lời xin lỗi
31:35 Rồi ta sẽ ngắm pháo hoa cùng nhau
35:47 Sai người sai thời điểm
40:46 Có lẽ bên nhau là sai
43:09 Ngày em đẹp nhất
47:59 Tan ca
51:31 Thật ra em chẳng thương anh vậy đâu
57:28 Có em là điều tuyệt vời nhất
1:00:00 Chúc các bạn nghe nhạc vui vẻ!
✪ Đừng bỏ lỡ hãy Đăng ký (Subscribe) Diệu Nhiên Lofi để đón nghe những bản nhạc hot nhất, mới nhất hiện nay nhé ! 
-------------------------------------------
Đăng ký nghe nhạc miễn phí nhưng vô cùng chất lượng: https://www.youtube.com/channel/UC2Tac_ZB0HY5RlfM1L0gvqg
Playlist mỗi ngày: https://youtube.com/playlist?list=PLI_Fxo3IkmWxmNaF0DP3Xp-yI9Rc_H9aj
-------------------------------------------
✉ Hợp tác, quảng cáo, khiếu nại các vấn đề về bản quyền liên hệ chúng tôi qua mail: td.nhunglth@gmail.com 
🔜 Website: https://tdnetwork.vn
🔜 Fanpage: https://fb.com/tdnetworkmusic
🔜 TikTok: https://www.tiktok.com/@tdnetworkmusic
-------------------------------------------
© Copyright TD Lofi
© Copyright by TD Network ☞ Do not Reup
---------------------------------------------
TAG:
Em là kẻ đáng thương lofi
Thay tôi yêu cô ấy lofi
Blackpink, lisa, jenny, rosé, jisoo
Hoa cỏ lau lofi
Thuyền quyên lofi
Gió lofi
Kiếp má hồng lofi
Vương vấn lofi
Cô đơn dành cho ai lofi
Khúc vương tình lofi
Giữa mênh mông đồi hoa cỏ lau, nhìn bông lau nghiêng giống, nhìn ngọn đèn mờ vội tắt, anh có cây bút nhưng không dùng vẽ hoa, từng giọt nắng chiếu xuống hết con đường.
Em mang phận là thiếu nữ, thân em chịu nhiều sóng gió.
Khúc vương tình, một chàng là chàng quên tử đế.
Ngàn vạn binh đao giương cao, Hướng về phía trước ta.
Cả đời anh không dám mơ chỉ vì mình đi quá xa.
Xa xa bóng người thương loáng thoáng trước thềm nhà đang đưa dâu.
Trời sinh ra kiếp má hồng 12 bến nước giữa dòng.
Cô đơn dành cho ai đây bao nhiêu tương tư tàn hoa phai.
Nếu mai sau anh và em có già đừng lo nhé có anh đây mà.
Chạy theo chân cơn sóng đi tìm ai ở nơi xa xôi
Trời hôm nay tắt nắng rồi trong căn phòng tăm tối.
Từ ngày gặp em con tim ngân nga khúc vương tình ca.
Thà là người cứ nói 1 lời...
Thanh xuân của người anh yêu anh đã lấy...
Người ấy vì thương tôi chờ đợi tôi cũng lâu rồi!!', N'https://i.ytimg.com/vi/d4M7dTL7DwY/maxresdefault.jpg', N'Nhạc Lofi Chill Top Xu Hướng 2024 Triệu View ♬ Nắng Có Mang Em Về, Nợ Ai Đó Lời Xin Lỗi, Mây', N'0', N'd4M7dTL7DwY')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'6538F4CB-CD74-4C9E-BF27-59D643F67ABE', N'1', N'2024-11-05 00:18:28.9324289', N'Em có quen người nào chưa sao mỗi tối anh chẳng thấy ai đón đưa?

Lưu Luyến Sau Chia Tay - Try92 ft. Kai06
Audio/Stream: https://daci.dfan.to/LLSCT
Spotify: https://daci.dfan.to/LLSCT/spotify
Apple Music: https://daci.dfan.to/LLSCT/apple_music
Zing MP3: https://daci.dfan.to/LLSCT/zingmp3
Youtube Music: https://daci.dfan.to/LLSCT/youtube_music
Distributed by DACI Entertainment

Executive Producer: Ánh Nhi
Singer: Kai06, Try92
Composer: Kai06, Try92
Producer: Nguyễn Ngân
Mix & master: Nguyễn Ngân 
Editor & Designer: Đài Nguyễn
Social: Hải Ngọc
PR Manager: Ánh Nhi
Media Partner: DACI Entertainment, DAMI Media

Lyric Lưu Luyến Sau Chia Tay:
Mới đây thôi đôi tay vẫn còn nắm chặt lắm, 
Vừa cách xa thôi em chỉ cười và xem nhau như người lạ 
Chạm vào trong những hoài ức cố quên đi những thói quen
Đôi tay đã buông xa rồi chỉ mong em được vui, 
Lạc lõng  giữa dòng người sao anh cứ ôm những bóng hình em 
Đặt vài câu hỏi an ủi lòng bớt nhớ em.

Chia sẻ những thứ anh vẫn thường làm khi có em cho cô gái anh vừa quen 
Nhẹ nhàng nâng lên vài điếu thuốc những ngày mưa đêm 
Em có quen người nào chưa sao mỗi tối anh chẳng thấy ai đón đưa 
Anh chẳng thể yêu thêm ai nữa vì em vì những ngày xưa
Thành phố như chật chội hơn sao chẳng  thấy yêu thương mà chỉ mình anh cô đơn 
Chơi vơi giữa đêm em à, sao nỡ rời xa. 

Rap
Đi qua những ngày mưa 
Em ơi đã về chưa 
Chỉ còn lại kỷ niệm cùng vài tỉ chuyện em của ngày xưa 
Anh vẫn chưa một lần được nói 
Cũng chẳng níu được nổi
Hạnh phúc rồi sẽ tắt đi trước khi mất đi đã có được rồi  
Anh đi thật chậm, nhìn lại nơi ta từng đi qua 
Hình bóng em vẫn còn đang thấy trên từng trang giấy anh còn ghi ra 
Trong lòng này như là tiết cuối sau cùng tiếc nuối chẳng ngừng suy nghĩ
Gặp lại nhau chẳng biết nói chào chỉ biết cúi đầu thôi người tri kỷ 
Ở trong phòng tối 
Yêu em bằng cả trái tim lại xa vì lời nói 
Một lần nhất thời nên mất rồi 
Tâm tư mơ màng về những ngày cuối 
Trời thì tối đen trong lòng này chẳng thể nói lên 
Chỉ còn lại trong lòng cố chấp vẫn là cố lấp đi những thói quen
Em có quên người nào đó chưa 
Nắm tay em dù trời có mưa 
Đưa em đi qua những ngày nắng sao chuỗi ngày vắng chẳng còn đón đưa 
Anh cố gắng nhắm đôi mắt lại không muốn nhắc lại mong một mai khác 
Vì trái tim chẳng thay đổi nên chỉ yêu mỗi em chẳng một ai khác

Chia sẻ những thứ anh vẫn thường làm khi có em cho cô gái anh vừa quen 
Vì còn thương nhưng ngại lắm đấy, mình vừa chia tay
Những dòng tin nhắn anh vẫn thường đọc khi đã xa nên mới kịp nhận ra
Là chẳng trân trọng em bao ngày qua

Em có quen người nào chưa sao mỗi tối anh chẳng thấy ai đón đưa 
Anh chẳng thể yêu em thêm ai nữa vì em vì những ngày xưa
Thành phố như chật chội hơn sao chẳng thấy yêu thương mà chỉ mình anh vấn vương
Chơi vơi giữa đêm em à, sao nỡ rời xa 

Ngày em ra đi mang những thói quen xưa đọng lại trên những vết mưa 
Một phút im lặng sang một giây đổ vỡ  
Mưa kia đã mang những ân tình anh đã mất em rồi thôi rồi chỉ có nơi đây mình tôi 
Em có quen người nào chưa sao mỗi tối anh chẳng thấy ai đón đưa 
Anh chẳng thể yêu em thêm ai nữa vì em vì những ngày xưa
Thành phố như chật chội hơn sao chẳng thấy yêu thương mà chỉ mình anh vấn vương
Chơi vơi giữa đêm em à, sao nỡ rời xa.

More information about DACI Entertainment
▶ Fanpage: https://www.facebook.com/daci.ent

More information about Kai06
▶ Facebook: https://www.facebook.com/bu.thanh.hh 

More information about Try92
▶ Fanpage: https://www.facebook.com/Try922000

© Bản quyền thuộc về DACI Entertainment
© Copyright by DACI Entertainment ☞ Do not Reup', N'https://i.ytimg.com/vi/ycMYhQsifTI/maxresdefault.jpg', N'Lưu Luyến Sau Chia Tay - Try92 ft. Kai06 | Official Lyrics Video', N'0', N'ycMYhQsifTI')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'C2393520-3AA9-4EE7-B57E-5BBBE28D9086', N'1', N'2024-11-05 07:25:03.4726749', N'Buy Sugar on iTunes: http://smarturl.it/M5V

Sign up for updates: http://smarturl.it/Maroon5.News

Catch Maroon 5 on tour all year long  at www.maroon5.com

Music video by Maroon 5 performing Sugar. (C) 2015 Interscope Records', N'https://i.ytimg.com/vi/09R8_2nJtjg/maxresdefault.jpg', N'Maroon 5 - Sugar (Official Music Video)', N'0', N'09R8_2nJtjg')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'5D623327-6667-42C4-8604-5E85F16FC6D8', N'1', N'2024-11-02 17:15:04.8783389', N'TTeam - MUỐN NÓI VỚI EM [Official MV] KIỀU MINH TUẤN , LÊ CHI

#MuonNoiVoiEm #TTeam #Blackbi #ThaiVu #KieuMinhTuan #LeChi #MaiXuanThu #DT 
 #FreeFire #OngSuiBaoNgu #Gaspa #MonAmie #DienQuanNetwork #Suzuteam #FapTV #YinYangMedia  
_____
NCT: https://bit.ly/3dF6G10
Spotify: https://spoti.fi/3ctqHX4
iTunes:https://apple.co/3dBF1xW
Apple:https://apple.co/3drP1Kd
Keeng: https://bit.ly/2XCmPyP

►Cảm ơn sự đồng hành của các đơn vị:  
FreeFire : https://ff.garena.vn/
Súp Bào Ngư Vi Cá Ông Sủi : https://www.facebook.com/supbaonguvicaso1/
Gà Spa : https://gaspa.vn/
Veston Mon AMie : https://monamie.vn/
►Đơn vị truyền thông: Điền Quân Network, YinYang, FapTv, Suzu Team ,Mood Entertainment
_________________________________________________________
MUỐN NÓI VỚI EM [MV OFFICIAL]

Executive Producer: Thái Vũ
Producer: Uncle Lee

Director: Nhảnh Lê
Assistant Director: Triệu Thiên
Director of Photography: Kisidon Nguyễn
Camera Operator: Phạm Kỳ Thiệu
Focus Puller: Nguyễn Kiên
Assistant Camera: Nguyễn  Ân
Gaffer: Ngô Trọng Phúc
Lighting Crew: Lê Ngọc Bích, Lương Công Bôn, Nguyễn Thanh Phong, Hoàng Nghĩa Đức, Dương Quốc Anh
Props Master: Hoàng Trọng, Minh Tuấn

Editor: Kiều Trọng Vũ
DIT: Kiều Trọng Vũ
Colorist: Kiều Trọng Vũ

Catering: Jupi Mol
Make –up: Team Minh Trung
Hair stylist: Lê Đình Toản

Composer: T-Team
Arranger: Nguyễn Hữu Vượng
Guitarist: Vũ Hoàng
Recording-Mix-Master:Dio
Background Vocals & Harmony: CoCha

Screenmwriter: Thái Vũ
Poster Designer: Lê Đăng
Behind The Scenes: An Huy
Flycam: Lâm Văn Hiếu

Starring: Kiều Minh Tuấn, Lê Chi
Cast: Thái Vũ, Mai Xuân Thứ

Đoàn phim xin chân thành cảm ơn
Cesar Homestay – 124 Nguyễn Đình Chiểu, phường Hàm Tiến, tp. Phan Thiết
Hill Lodge Mui Ne – E6 Nguyễn Tấn Định, khu phố 1, phường Hàm Tiến, tp.Phan Thiết

Thanks to Điền Quân Network (Nguyễn Vy), YinYang, FapTv, Suzu Team

Follow Us:
▶ Kênh Youtube : https://bit.ly/2IviSGi
▶ Facebook cá nhân Blackbi TTeam : https://www.facebook.com/blackbi.thaivu
▶ Facebook cá nhân Mai Xuân Thư TTeam : https://www.facebook.com/MaiXuanThu.FAPtv/
▶ Facebook cá nhân DT TTeam : https://www.facebook.com/tteam.dt
▶ Email Booking Show : https://www.thaivufap@gmail.com

Cả nhà đang ở kênh Youtube chính thức của  BlackBi Team. 
Mọi người ơi nhớ Subscribe, Like và Share để ủng hộ tinh thần cho TTeam
Nhạc và Hoạt Động của TTeam được up ở kênh này. Cảm Ơn Mọi Người
Rất cảm ơn Mọi Người đã ủng hộ Blackbi và TTeam trong suốt thời gian qua .
-----------
© Bản quyền thuộc về BLACKBI ORIGINAL , TTeam Entertainment
©COPYRIGHT BY BLACKBI ORIGINAL, DO NOT RE-UP!', N'https://i.ytimg.com/vi/5TlJtpytXtk/maxresdefault.jpg', N'TTeam - MUỐN NÓI VỚI EM - DT Tập Rap ft Mai Xuân Thứ  [Official MV] KIỀU MINH TUẤN , LÊ CHI, BLACKBI', N'0', N'5TlJtpytXtk')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'CD691AC3-B428-496C-A678-6246F64B893E', N'1', N'2024-11-05 07:25:04.4268622', N'Official video for “Stay” by The Kid LAROI & Justin Bieber.
 
Listen & Download “Stay” out now: https://thekidlaroi.lnk.to/Stay
 
Amazon Music - https://thekidlaroi.lnk.to/Stay/amazonmusic
Apple Music - https://thekidlaroi.lnk.to/Stay/applemusic
Audiomack - https://thekidlaroi.lnk.to/Stay/audiomack
Deezer - https://thekidlaroi.lnk.to/Stay/deezer
iTunes - https://thekidlaroi.lnk.to/Stay/itunes
SoundCloud - https://thekidlaroi.lnk.to/Stay/soundcloud
Spotify - https://thekidlaroi.lnk.to/Stay/spotify
YouTube Music - https://thekidlaroi.lnk.to/Stay/youtubemusic
 
Directed by Colin Tilley
Executive Produced by Jamee Ranta, Colin Tilley
Produced by Jack Winter
Cinematographer Elias Talbot
Editor Vinnie Hobbs @ VHpost
Color Bryan Smaller
Vfx Digital axis
Production Co Boy in the Castle, LLC
 
Follow The Kid LAROI
Facebook - https://www.facebook.com/thekidlaroi
Instagram - https://www.instagram.com/thekidlaroi/
Twitter - https://twitter.com/thekidlaroi
TikTok - https://www.tiktok.com/@thekidlaroi
 
Follow Justin Bieber
Facebook - https://www.facebook.com/JustinBieber
Instagram - https://www.instagram.com/justinbieber/
Twitter - https://twitter.com/justinbieber
TikTok - https://www.tiktok.com/@justinbieber
 
#TheKidLAROI #JustinBieber #Stay', N'https://i.ytimg.com/vi/kTJczUoc26U/maxresdefault.jpg', N'The Kid LAROI, Justin Bieber - STAY (Official Video)', N'2', N'kTJczUoc26U')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'382B4CE7-D3C1-4D00-9163-6F263325EF2D', N'1', N'2024-11-05 00:18:28.6348197', N'Làm beat, mix master, viết nhạc, thu âm: Ronboogz 
Làm cái clip này: Nguyễn Đức Trọng
__________
Follow Ronboogz cho vui:
-Facebook: https://www.facebook.com/Ronboogz95/ 
-Instagram: https://www.instagram.com/ronboogz95/

Nghe trên các nền tảng khác tại đây: https://ronboogz.daomusic.to/nhannhu', N'https://i.ytimg.com/vi/vfKiaXKO44M/maxresdefault.jpg', N'Nhắn nhủ | Ronboogz (Lyrics video)', N'0', N'vfKiaXKO44M')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'26ACF2C6-7309-47FC-8BE0-712723B90F0B', N'1', N'2024-11-05 07:25:04.0355003', N'“Daylight” out now on all platforms: https://davidkushner.lnk.to/daylight

Lyrics:

[Verse 1]
Telling myself I won''t go there
Oh, but I know that I won''t care
Tryna wash away all the blood I''ve spilt
This lust is a burden that we both share
Two sinners can''t atone from a lone prayer
Souls tied, intertwined by pride and guilt

[Pre-Chorus]
(Ooh) There''s darkness in the distance
From the way that I''ve been livin''
(Ooh) But I know I can''t resist it

[Chorus]
Oh, I love it and I hate it at the same time
You and I drink the poison from the same vine
Oh, I love it and I hate it at the same time
Hidin'' all of our sins from the daylight
From the daylight, runnin'' from thе daylight
From the daylight, runnin'' from the daylight
Oh, I love it and I hatе it at the same time

[Verse 2]
Tellin'' myself it''s the last time
Can you spare any mercy that you might find
If I''m down on my knees again?
Deep down, way down, Lord, I try
Try to follow your light, but it''s nighttime
Please don''t leave me in the end

[Pre-Chorus]
(Ooh) There''s darkness in the distance
I''m beggin'' for forgiveness
(Ooh) But I know I might resist it, oh

[Chorus]
Oh, I love it and I hate it at the same time
You and I drink the poison from the same vine
Oh, I love it and I hate it at the same time
Hidin'' all of our sins from the daylight
From the daylight, runnin'' from the daylight
From the daylight, runnin'' from the daylight
Oh, I love it and I hate it at the same time
Oh, I love it and I hate it at the same time
You and I drink the poison from the same vine
Oh, I love it and I hate it at the same time
Hidin'' all of our sins from the daylight
From the daylight, runnin'' from the daylight
From the daylight, runnin'' from the daylight
Oh, I love it and I hate it at the same time


Production Company / Altar 8 Studio

CREW
Director/Dp - Luke Shaw & Landon Juern
1st AC - Aaron Roams
Steadicam - Zachary Stanke
Photographer - Lizzy Juern
Videographers - Matthew Vietzke & Gerado Manuel Ortiz

POST
Vfx artist - Ryan Game
Editor - Landon Juern
Colorist - Luke Shaw

TALENT
Man on fire - Yonel Cohen
Boy - Leo Brien
Artist - David Kushner

PRODUCTION:
Producer - Rob Kirwan
Mixing - Jacob Morris / GetMXD 
Mastering - Jacob Morris / GetMXD 
Dolby Atmos - Jacob Morris / GetMXD

WRITERS:
David Kushner
Hayden Hubers 
Jeremy Fedryk
Josh Bruce Williams 

ARTWORK:
Jon Taylor Sweet

MANAGEMENT:
Brent Shows

David Kushner Socials 
•  Instagram: https://www.instagram.com/david.kushn...
•  TikTok: https://www.tiktok.com/@davidkushner?...
•  Twitter: https://twitter.com/davidkushner_
•  YouTube:   
 / followkush  
•  Facebook: http://facebook.com/davidkushnermusic
•  Website: https://davidkushnermusic.com/

Miserable Music Group, LLC', N'https://i.ytimg.com/vi/MoN9ql6Yymw/maxresdefault.jpg', N'David Kushner - Daylight (Official Music Video)', N'0', N'MoN9ql6Yymw')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'B48558C6-4E65-4077-8D67-71F063854166', N'1', N'2024-11-02 17:05:03.4136780', N'Script : Yến Vy, Đức Viễn, Vinh Râu, Thái Vũ, Nikola, Yên Dương, Phúc Vũ, Vinni
Director : Trần Đức Viễn
Producer : Trần Long
D.O.P : Trần Long
1st AD : Thanh Sang
 2nd AD : Phan Yến
3nd AD : Trần Lâm
Cast : Vinh Râu , Thái Vũ , Huỳnh Phương, Thúy Kiều, Bình Hưng, Uy Trần, Yên Dương, Trần Long, Lê Trường, ...Cùng với một số diễn viên khác
Gaffer : Nikola
Light : Nikola, Gia Huy, James Zai, Nguyễn Khang
Camera Operator : Trần Long, Đặng Duy Phong, Việt Lê, Đàm Hiển, Ngọc Hòa
Equipment : Việt Lê, Ngọc Hoà, Đàm Hiển, Tuấn Kiệt, Đỗ Hoàng Lâm
M.U.A : Trinh Angel, Bích Trâm 
Stylist: Lữ Phượng Trinh
Prop Decoration : Hải Lê, Hoàng Trọng, Minh Tuấn
Sound : Trần Linh Soundteam
Location Manager : 9 Tâm, Lê Quốc Tuấn
Extra Casting :  Thanh Thuý
Master : Đức Viễn
Color : Lê Duy
Editor : Lê Duy, Hoàng Kiên, Trọng Khôi
Designer : Tuấn Kiệt
Film composer : Quang Vinh
Soundeditor : Lê Duy
Account Manager : Tài Nguyễn
Marketing : Tài Nguyễn, Thuỷ Tiên
Cateerer : Tiger
Driver : Giai
Location : Tony Quốc Anh
Behind The Scene : Vũ Ngọc Vinh
#faptv #cơmnguội #phimhai #vinhrau #huynhphuong #thaivu #haihuoc #giaitri #ribisachi #COMNGUOI #haifaptv #hài #haikich', N'https://i.ytimg.com/vi/fNdMGKxA1y0/maxresdefault.jpg', N'FAPtv Cơm Nguội: Tập 321 : Jack Ma ( Phim Hài Halloween 2024)', N'1', N'fNdMGKxA1y0')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'01B0FF29-4979-4D78-ABEB-769FE7E32CDB', N'1', N'2024-11-05 00:18:30.3322871', N'10 Ngàn Năm - PC
Download/Stream: https://backl.ink/144198720

Prod. by Duckie
Composer : PC FeelingSoundz
Artwork: A Chinese Odyssey Part
#10NganNam #PC #TaynguyenSound #TNS4Life

follow Duckie:
https://www.facebook.com/Duckiecongchua
https://www.instagram.com/chuvitnhobe/
https://soundcloud.com/convitcon

follow PC:
Facebook: https://www.facebook.com/PCTaynguyenSound
Instagram: https://www.instagram.com/Peacefeelingsoundz
Tiktok: https://www.tiktok.com/@pc.tns
Fanpage: https://www.facebook.com/PCFeelingSoundz

© 2019 PC FeelingSoundz

____

Lyrics:
Ver 1:
Sao không là ta của những lúc thường ngày ?
hm.. Sao hôm nay anh buồn vầy ?
Vì, có những nỗi niềm lặng thầm
Th..Thôi xin em đừng nặng tâm
Vậy coi như, mình không thể sống chung, là sự chia ly của nhau trong đời người
Thì em yêu thương hãy, hãy cứ vui, để mai đây em nhớ lại chợt cười
 Mình sẽ bên nhau ở muôn kiếp sau - Hay sẽ không biết nhau ?-
Tim là sỏi đá thì cũng phải biết đau, yêu thương làm gì anh không luyến tiếc đâu.
Biết có không em, mình sẽ lại tương phùng, tái ngộ bên trong hình hài khác
 Gặp nhau, nhưng mà chỉ, cảm thấy lòng mơ hồ man máng như lời một bài hát
Có biết không em, từ những sai sót đó, anh chỉ mong em, gặp được ai tốt số
Người sẽ rước em bằng những dải mây hồng, mà không phải thay lòng vì một ai chót nhớ. 
Hay phận trời, ta phải cứ vâng lời
Em sẽ chờ đến, đến một kiếp luân hồi
Để mình tìm nhau tự nhiên như cảm hứng
Đòi hòa vào nhau như một sự phản ứng 
Hay lúc đó mình sẽ không nhận ra
uch..biết được đâu, em ơi duyên phận mà
Anh sẽ cố nhớ em từng là ai đây ? Từ cử chỉ, giọng nó i từng chi tiết
Hãy là sao trời, mây trắng hoặc mùa thu, hoặc phiêu linh trong anh mỗi khi viết
Nếu là thánh thần anh biết mình toàn năng
Nguyện giới hạn cuộc tình đến 10 ngàn năm.

Bridge :
Người tình hỡi dẫu có mấy lúc biết phải chia ly
Dù buồn đau cũng chẳng thế giúp ta giải quyết gì
Cảm nhận nhau qua từng nhịp thở
hmmm Lê đôi anh đi tìm gì ở cuối chân trời
Chờ đợi điều diệu kỳ để mình mãn kiếp luần hồi
hẹn em, đời sau, mình sẽ, tìm nhau, thêm một lần, vẹn duyên
   

Ver 2 :
Giữ em lại sâu nơi tiềm thức, xác thịt này một -lần được mang
Thôi anh không hờn trách bởi vì đời người vốn dĩ là hợp tan
Mình lỡ làng đến khi vãn kiếp, em ơi xin hãy là gì hiện hữu
Em sẽ lại đến rồi em sẽ lại đi, anh vẫn kể lại những câu chuyện cũ
Rằng mình ngây thơ thế nào, ngu ngơ đến cười, muốn mai này nên người vợ người chồng
Để tay bế và bồng, đứa bé đầu lòng, với chúng ta đó là mặt trời hồng
 Nếu về một nhà càng mong mình đơn giản, sáng mỗi ngày em cài cho khuyên áo
Ra trước hiên em rót một cóc trà, xà vào lòng nhau ngắm dòng đời huyên náo
Hay là bờ cát và tiếng sóng dờn vàng, Em có nghe thấy lớp nhỏ cười dòn tan
Em muốn ở đâu ? Khuất sâu nơi địa đàn hay là một căn nhà trên chốn đồi hoang
Vòng luân hồi làm người ta mệt mỏi... có em rồi đời sống này khỏe hơn
Làm người nội trợ cực nhọc đi ít nhiều, vì anh muốn nuôi mèo, nhà có cả trẻ con 
Mà đúng phải lẽ ra, anh cần trách nhiệm, trưởng thành, vươn cao cho gia đình dựa bóng
Dẫu sai lầm thì vẫn là kết quả, của thời thanh niên mình tràn trề nhựa sống
Cũng chẳng mơ tình đẹp như vườn hông, sẽ úa tan vội vàng chẳng mấy lâu
Anh chỉ mong mình sẽ mãi trường tồn, để nghìn đời vẫn muốn tìm thấy nhau', N'https://i.ytimg.com/vi/2-zSSzg8i3Y/maxresdefault.jpg', N'PC - 10 Ngàn Năm ( Prod. Duckie ) [Official Audio]', N'0', N'2-zSSzg8i3Y')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'FAEE9C22-E47D-4135-8467-797349B62593', N'1', N'2024-11-05 00:18:29.7717901', N'#Nguyenn #Dangtuanvu #HEOLYT2 #DAOMusicEntertainment
Hẹn Em Ở Lần Yêu Thứ 2 - Nguyenn x Đặng Tuấn Vũ  | OFFICIAL MUSIC VIDEO |

Landing Page: https://Nguyenn.daomusic.to/HEOLYT2
Spotify: https://Nguyenn.daomusic.to/HEOLYT2/spotify
Apple Music: https://Nguyenn.daomusic.to/HEOLYT2/apple_music
Zing MP3: https://Nguyenn.daomusic.to/HEOLYT2/zingmp3
Nhaccuatui https://Nguyenn.daomusic.to/HEOLYT2/nct

Composer: Nguyenn
Singer: Nguyenn x Đặng Tuấn Vũ
Background vocal: Duy Ngọc
Producer: Vitagen
Mix& Mastering: Duy Ngọc
Distributor: DAO Music Entertainment
Project manager: Do Le Thanh Trung
Make up: Cam Ly
Director/DP: Duy Phan
Editor/ Colorist: Thành Nguyễn
Production Asistant: Tu Anh Dao
Designer: BLac, Truc Ban Bun
Media partner: Brave(Tiktok), Những bản nhạc buồn(Tiktok), ACV Entertainment, DS Music, Aric, Dawn, 

Lyrics: 
"Mọi chuyện rồi cũng sẽ ổn thôi đúng không anh ơi?"
Là điều em nói lúc em muốn chúng ta xa rời
Anh không dám trả lời tin nhắn ấy
Cứ giả vờ như mình chẳng nhìn thấy đâu
Anh thương cho mối tình của hai đứa
Phải kết thúc như vậy sao?

Thời gian trôi như gió vội bay qua trời''
Nhiều chuyện anh cứ chôn thật sâu chẳng muốn mở lời
Ngày ngày lo cho tương lai
Nhưng em cứ ngỡ anh đã có ai
Bên nhau cả quãng đường dài
Mà giờ em nói em muốn dừng lại

Anh phải làm gì để em đừng nghĩ: "Em không quan trọng"
Nuốt hết đắng cay vào trong lòng
Cuộc đời anh như con số 0
Cha mẹ già vất vả, đêm ngủ chẳng ngon
Phận làm con anh đây chữ hiếu chưa tròn
Anh phải bù đắp cho em bao nhiêu để em chẳng còn thấy thiếu?

"Dành hết cả thanh xuân này cho nhau, liệu còn bên nhau lúc mai sau?"
Có phải ngay lúc đầu, em đã chẳng chọn anh đâu?
Anh vẫn muốn ngày thành công, sẽ được che chở em
Còn em đợi ngày đó để có thể yên tâm rời xa anh''
Liệu có quá nhẫn tâm?


Mọi chuyện buồn, mình sẽ vượt qua phải không em à?
Là điều anh muốn, nhưng anh chẳng thể nói ra
Anh không muốn mình, phải quên mất hết
Chẳng muốn mình trôi khỏi ký ức của em
Anh thương cho người con gái, cạnh bên anh dẫu chẳng có tương lai
Có những đoạn đường, ta buộc phải bước một mình em à
Có những nỗi niềm anh gửi vào gió, chẳng muốn nói ra
Không ai muốn phải chia xa, rồi làm bạn với người mình yêu nhất cả
Bên nhau bao lâu vậy mà, một vài câu nói, em bỗng xa lạ


Anh phải làm gì để em đừng nghĩ em không quan trọng
Nuốt hết đắng cay vào trong lòng cuộc đời anh như con số 0
Em vẫn còn thương anh đúng không?
Cuộc đời bao lo toan anh chẳng muốn phiền lòng
Năm tháng có quay lại không?
Hay chỉ cho ta thêm một khoảng trống

Dành hết thanh xuân này bên nhau, bây giờ thanh xuân ấy nơi đâu?
Có phải ngay lúc đầu, ta vốn chẳng dành cho nhau?
Anh không muốn em phải đau, phải đợi anh quá lâu
Chờ đợi từng lời hứa, anh chẳng thể tin bản thân mình được nữa
Vậy ta kết thúc được chưa?

"Hẹn em ở lần yêu thứ 2"

Credit “Mùa Mưa Ngâu”
- Sản xuất/ Producer: Nguyễn Vũ Hiền Chi
- Đạo diễn/ Director: Nguyễn Tiến Duy
- DP: Phan Quang Duy
- Trợ lý đạo diễn/ AD: Vũ Trung Đức
- Trợ lý sản xuất/ PA: Nguyễn Ngọc Lân, Kiên Duy
- Thiết kế mỹ thuật/ Art Director: Trung Kiên
- Set Design/ Thi công bối cảnh: Quang Anh, Tài Nghiêm
- Trợ lý mỹ thuật/ Best Boy: Đinh Minh Hải
- Hoá trang/MUA: Vũ Khánh Linh, Cẩm Ly
- Phục trang/ Stylist: Chang
- Trợ lý phục trang: Phạm Thị Thảo Vân
- Âm Thanh/ Boom Operator: Trần Quang Tiến
- DIT: Phạm Quốc Hiệu
- Trợ lý DIT: Hoàng Bùi
- Đội kỹ thuật và thiết bị
*  Quay phim/ Cam Op: Duy Phan mini
* Gaffer:
* Kỹ thuật đèn: Trần Bình
* Trợ lý quay phim/ AC: Nguyễn Thanh Tùng
* …
- Diễn viên/ Actress, Actor: Lê Mẫn Nhi, Đinh Quang Anh
- Support: Đức Minsu
- Đồ màu: Trần Công Minh
- Hậu kỳ âm thanh: Anh Nguyễn Ngọc Hùng
- Xin chân thành cảm ơn:
* Chị Hạnh, anh Cù, anh Hoàng, Chị Mây tại của hàng Bốt cafe - Võ Văn Dũng, Đống Đa, Hà Nội
* Toàn thể học sinh và thầy cô giáo Trường THPT Kim Liên, Trung Tự, Đống Đa, Hà Nội
* Cán bộ tổ trường và người dân tại Sân chơi Khu Tập thể D3 Trung Tự, Đống Đa, Hà Nội
* Em Nguyễn Huy Phong
* Em Đỗ Hoàng Anh Tuấn
* Em Lan Anh
* Em Phạm Quang Tuấn
* Em Nguyễn Hoàn
* Em Thái Trung Thành

More information about Nguyenn: 
Email: Boomdragon95@gmail.com
Facebook: https://www.facebook.com/nttrui/
Youtube: https://www.youtube.com/channel/UCzYR...
Tiktok: https://www.tiktok.com/@nguyentranb?
Soundcloud: https://soundcloud.com/nguy-n-tr-n-official

Follow Đặng Tuấn Vũ:
Facebook: https://www.facebook.com/Dangtuanvux1996
Fanpage: https://www.facebook.com/dangtuanvu.vn
Gmail: Bkdangtuanvu@gmail.com
Tiktok: https://www.tiktok.com/@dangtuanvu_
Instagram: https://www.facebook.com/Dangtuanvux1996

-----------------------
Bản quyền thuộc sở hữu của Nguyenn
Entertainment Copyright © Nguyenn', N'https://i.ytimg.com/vi/lB3SRFPYf98/maxresdefault.jpg', N'Hẹn Em Ở Lần Yêu Thứ 2 - Nguyenn x @Dangtuanvu.Original  | Official MV | Anh phải làm gì để em...', N'0', N'lB3SRFPYf98')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'5FA750D5-1585-4499-8FC6-84B4C0231C98', N'1', N'2024-11-05 07:25:01.2528273', N'Tham gia làm hội viên của kênh này để được hưởng đặc quyền:
https://www.youtube.com/channel/UCky92hx0lZxVBi2BJ6Zm2Hg/join

👉 Link khóa học backend Go: https://www.youtube.com/playlist?list=PLw0w5s5b9NK6qiL9Xzki-mGbq_V8dBQkY

👉 Link khóa học backend Nodejs: https://www.youtube.com/playlist?list=PLw0w5s5b9NK4ucXizOF-eKAXKvn9ruCw8

👉 Link khóa học backend Java: https://www.youtube.com/channel/UCky92hx0lZxVBi2BJ6Zm2Hg/join

🚩  Subscribe  ➜https://www.youtube.com/c/TipsJavascript
#anonystick #mongodb #mysql 
✅  Follow Me:
Blog: https://anonystick.com
Github: https://github.com/anonystick/anonystick
Facebook: https://www.facebook.com/TipJS/
Youtube: https://www.youtube.com/c/TipsJavascript', N'https://i.ytimg.com/vi/tnUBjJJnwn0/maxresdefault.jpg', N'MYSQL BACKEND: Vì sao lại chọn MONGODB, chả phải MYSQL cũng làm được sao? 2/8 tiêu chí đáng suy ngẫm', N'8', N'tnUBjJJnwn0')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'DC0EAB6D-FB37-449A-9FA7-90E1D1E40A25', N'1', N'2024-11-05 07:25:01.8786552', N'Mục tiêu: Trong video này,  tôi sẽ không chỉ thảo luận về cách thực hiện Rebuild Index mà còn phân tích sâu hơn về nguyên tắc và chiến lược đằng sau nó. Chúng ta sẽ cùng xem xét các yếu tố quyết định khi nào nên và không nên đặt lịch định kỳ Rebuild Index, dựa trên tính chất của dữ liệu, yêu cầu hiệu suất, và mô hình sử dụng cụ thể của hệ thống 

Ghi chú: Nếu bạn là một lập trình viên và muốn phát triển sự nghiệp một cách nhanh chóng hơn. Tôi có một khoá học có thể giúp bạn phát triển rất nhanh (cả về CHIỀU RỘNG và CHIỀU SÂU), tại khoá học này bạn sẽ được chia sẻ tất cả những kinh nghiệm và kiến thức của tôi đã tích luỹ trong hơn 10 năm trực tiếp điều hành Wecommit - công ty chuyên tư vấn và tối ưu các cơ sở dữ liệu và hệ thống lớn.

Xem chi tiết khoá học của tôi ở đây: https://wecommit.com.vn/tu-dien-toi-uu-100x-hieu-nang/
Bạn có thể xem các dự án mà tôi đã trực tiếp thực hiện tại đây: https://wecommit.com.vn/du-an/

🎯 Một số Video khác bạn có thể xem:
- Quy trình 6 bước phải biết khi tối ưu câu lệnh SQL: https://www.youtube.com/watch?v=GfLN0sfU-7U
- Hiểu toàn bộ kiến thức về PostgreSQL trong 1h30 phút: https://www.youtube.com/watch?v=OUlLQK_gN8k
- Học SQL Server trong 60 phút : https://www.youtube.com/watch?v=alqEF4I23nw
- Học MongoDB trọn vẹn trong 1 giờ 30 phút: https://www.youtube.com/watch?v=8Nx7cdwT86c
- Hiểu kiến trúc của cơ sở dữ liệu Oracle trong 20 phút: https://www.youtube.com/watch?v=6icn0a5lKi4

📱 Nếu bạn muốn liên hệ với tôi:
Zalo: 0888549190
Linkedin: https://www.linkedin.com/in/huytq/
Facebook: https://www.facebook.com/tranquochuy.toiuu

🌐 Nguồn tài liệu: Tôi tổng hợp từ các kiến thức và kinh nghiệm của bản thân trong hơn 10 năm làm các dự án tối ưu cơ sở dữ liệu.
#toiuu100x #tranquochuy  #wecommit #databasedesign #databaseperformance #databasetutorial #toiuucosodulieu #thietkecosodulieu  #toiuusql', N'https://i.ytimg.com/vi/risDcyGb0k4/maxresdefault.jpg', N'Tranh luận: Có nên định kỳ Rebuild Index?', N'1', N'risDcyGb0k4')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'8B4FAC53-CE36-437F-B52C-911D946C8DEB', N'1', N'2024-11-02 17:15:05.4499281', N'#sinostudio #fgstudio #changtraibattu

Chàng Trai Bất Tử | SiNo ft. An Vũ (prod. by MKM)| SiNo studio MV

MV lấy cảm hứng từ những câu chuyện có thật!

MUSIC PRODUCTION
Composer: Sino
Singer: An Vũ
Producer/Mixing: MKM
Vocal background: MKM
 
MV PRODUCTION
Animation: Sino
Background: Trần Ngọc Anh
Editor: Nguyễn Minh Hiếu
Voice: Khang, Hima
Sfx: Nghếch
Sp: Hoàng Kiệt Kts

Landing page: https://YYM.lnk.to/ChangTraiBatTu
Spotify: https://YYM.lnk.to/ChangTraiBatTu/spotify
Apple Music: https://YYM.lnk.to/ChangTraiBatTu/applemusic
iTunes: https://YYM.lnk.to/ChangTraiBatTu/itunes
Tiktok: https://YYM.lnk.to/ChangTraiBatTu/tiktok
Zing mp3: https://YYM.lnk.to/ChangTraiBatTu/zingmp3
NCT: https://YYM.lnk.to/ChangTraiBatTu/nct
Keeng: https://YYM.lnk.to/ChangTraiBatTu/keeng

--------------------------------------------------------------------
Connect with Sino studio
Fanpage: https https://www.facebook.com/profile.php?id=100069323215001&mibextid=LQQJ4d
Tiktok: https://www.tiktok.com/@sino.studio?_t=8bJKwsPC2Ov&_r=1
-------------------------------------------------------------------- 
Bản quyền thuộc về Sino studio và FG studio
- Vui lòng liên hệ Sinostudio.fg@gmail.com nếu có bất cứ vấn đề về bản quyền!
--------------------------------------------------------------------
Hi vọng sẽ được hợp tác để phát triển những sản phẩm âm nhạc tuyêt vời với chất liệu animation!', N'https://i.ytimg.com/vi/oWENAdVkHRk/maxresdefault.jpg', N'Chàng Trai Bất Tử | SiNo ft. An Vũ (prod. by MKM)| SiNo studio MV', N'0', N'oWENAdVkHRk')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'CC06DFC7-02B1-4BAF-B140-91486E3ACC5E', N'1', N'2024-11-05 07:25:02.2698638', N'Website: https://sydexa.com
Tiktok: https://www.tiktok.com/@sydexa.com
Facebook: https://www.facebook.com/sydexa
Group: https://www.facebook.com/groups/sydexa

Editor: Nig Chil

Bài viết: https://sydexa.com/blog/con-chim-xanh-duolingo-va-bai-toan-gui-4-trieu-notification-trong-vong-5s-66929a16f9b1909b0e8dc68a

Những chiến dịch truyền thông và đội content của Duolingo đã rất thành công để giữ chân người dùng. Góp phần đưa ứng dụng này trở thành một ứng dụng nổi tiếng có 500 triệu người đã đăng ký tài khoản, với 32.4 triệu daily active user. Có đến 100 khóa học cho hơn 40 ngôn ngữ khác nhau.

Đó là nhờ đội marketing vô cùng đỉnh của chóp. Cùng Sydexa tìm hiểu bài toán tại Duolingo nha 🤓🤓🤓', N'https://i.ytimg.com/vi/Hfa90r2rDNc/maxresdefault.jpg', N'Con chim xanh Duolingo và bài toán gửi 4 triệu notification trong 5s', N'0', N'Hfa90r2rDNc')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'8D3B5DCE-A5BE-4814-8B1F-9707DE39FDF2', N'1', N'2024-11-05 07:25:01.6596660', N'#toiuusql  #toiuucosodulieu 

Mục tiêu: Sau mười năm hoạt động trong lĩnh vực cơ sở dữ liệu, cá nhân tôi thấy rằng việc nắm vững kỹ năng tối ưu SQL và tối ưu cơ sở dữ liệu có thể đóng vai trò quan trọng trong việc thúc đẩy sự phát triển sự nghiệp một cách hiệu quả. Trong video này, chúng ta sẽ cùng nhau phân tích nguyên nhân tại sao điều này lại quan trọng và các anh em DEV nếu biết được sẽ khác biệt thế nào nhé

Ghi chú: Nếu bạn là một lập trình viên và muốn phát triển sự nghiệp một cách nhanh chóng hơn. Tôi có một khoá học có thể giúp bạn phát triển rất nhanh (cả về CHIỀU RỘNG và CHIỀU SÂU), tại khoá học này bạn sẽ được chia sẻ tất cả những kinh nghiệm và kiến thức của tôi đã tích luỹ trong hơn 10 năm trực tiếp điều hành Wecommit - công ty chuyên tư vấn và tối ưu các cơ sở dữ liệu và hệ thống lớn. 

Xem chi tiết khoá học của tôi ở đây: https://wecommit.com.vn/tu-dien-toi-uu-100x-hieu-nang/
Bạn có thể xem các dự án mà tôi đã trực tiếp thực hiện tại đây: https://wecommit.com.vn/du-an/

🎯 Một số Video khác bạn có thể xem:
- Quy trình 6 bước phải biết khi tối ưu câu lệnh SQL: https://www.youtube.com/watch?v=GfLN0sfU-7U
- Hiểu toàn bộ kiến thức về PostgreSQL trong 1h30 phút: https://www.youtube.com/watch?v=OUlLQK_gN8k
- Học SQL Server trong 60 phút : https://www.youtube.com/watch?v=alqEF4I23nw
- Học MongoDB trọn vẹn trong 1 giờ 30 phút: https://www.youtube.com/watch?v=8Nx7cdwT86c
- Hiểu kiến trúc của cơ sở dữ liệu Oracle trong 20 phút: https://www.youtube.com/watch?v=6icn0a5lKi4

📱 Nếu bạn muốn liên hệ với tôi:
Zalo: 0888549190
Linkedin: https://www.linkedin.com/in/huytq/
Facebook: https://www.facebook.com/tranquochuy.toiuu

🌐 Nguồn tài liệu: Tôi tổng hợp từ các kiến thức và kinh nghiệm của bản thân trong hơn 10 năm làm các dự án tối ưu cơ sở dữ liệu.
#toiuu100x #tranquochuy  #wecommit #databasedesign #databaseperformance #databasetutorial #thietkecosodulieu', N'https://i.ytimg.com/vi/T1Qa7_PM91k/maxresdefault.jpg', N'Anh em DEV chưa từng tối ưu SQL nên xem video này #wecommit #tranquochuy', N'1', N'T1Qa7_PM91k')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'4CEBEEBC-9A76-452A-85FE-97E78A26FFDA', N'1', N'2024-11-05 07:25:02.5051925', N'Cộng đồng System Design Việt Nam: https://www.facebook.com/groups/sydexa
Website: https://sydexa.com
Tiktok: https://www.tiktok.com/@sydexa.com
Facebook: https://www.facebook.com/sydexa

Editor: Nig Chil

Trong lĩnh vực các hệ thống phân tán quy mô lớn, một thành phần quan trọng thường ẩn phía sau là Bộ Sinh Mã Định Danh Duy Nhất (ví dụ như sinh mã primary key cho table trong database). Những mã định danh này đóng vai trò then chốt trong việc đảm bảo tính toàn vẹn, nhất quán và khả năng mở rộng của các ứng dụng hiện đại. Trong bài viết này, chúng ta sẽ khám phá vào thế giới của nó, tìm hiểu tầm quan trọng, các loại khác nhau, ưu và nhược điểm của chúng.', N'https://i.ytimg.com/vi/N7BV_rRse30/maxresdefault.jpg', N'Cách sinh mã ID cho hệ thống phân tán', N'0', N'N7BV_rRse30')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'2FC555D4-7464-4619-BD61-9852C2051446', N'1', N'2024-11-05 00:18:31.1317647', N'CHỜ ĐỢI CÓ ĐÁNG SỢ | ANDIEZ | 
Composed & Performed : Andiez
————————————
Andiez xin được gửi lời cảm ơn chân thành đến các anh chị báo chí , các đơn vị truyền thông , nhãn hàng và các pages đã đi cùng với Andiez trong sản phẩm trở lại lần này.

Em xin được cảm ơn đến chị quản lý  , ekip sản xuất MV Tụi Tui Productions , em Trâm Ngô và anh Njay Nhựt Nguyễn , chị Phương Nguyễn (YinYang) , Hieustudio , anh Đoàn Minh Vũ và anh Trần Việt Dương , các bạn B3212 Productions , Cổ Động On Air , nhãn hàng DirtyCoins vì đã support Andiez để có thể tạo nên "Chờ Đợi Có Đáng Sợ" đầy tự hào như thế này.

Cảm ơn Yin Yang Media , Spotify , Keeng , NCT , Apple Music đã đồng hành cùng với Andiez trong dự án lần này.

Lời cảm ơn cuối cùng , Andiez xin được gửi đến các bạn khán giả đã luôn theo dõi và đồng hành cùng Andiez trong suốt thời gian qua , Andiez sẽ hứa trong thời gian tới cố gắng hơn nữa để không phụ lòng mọi người vì đã yêu thích âm nhạc của Andiez.

Project Manager : NGUYỄN NGỌC PHƯƠNG OANH
Excutive Producer : NAM TRƯƠNG

Music Producer : ĐOÀN MINH VŨ - TRẦN VIỆT DƯƠNG - ANDIEZ
Quartet Strings : ĐOÀN MINH VŨ
Guitarist : TRẦN VIỆT DƯƠNG
Rec & Mix/Master : LÊ MINH HIẾU - KRIS VŨ (hieu studio)
TuiTui Production 
Director : LÂM TẤN HUY
D.O.P : KISIDON NGUYỄN
Producer : NGUYỄN PHÁT - THẢO NGUYỄN
Line Producer : HÀ LÊ
1st A.D : HIỂN MIKE 
Advisor : NGUYỄN DUY LINH
Cam Op : PHẠM KỲ THIỆU
Focus Puller : KIÊN NG
Production Assistant : THIÊN THƯ 
Editor-DIT-Colorist : KIỀU TRỌNG VŨ 
VFX : KHOA DANH NGUYỄN VŨ
Lighting :DH FILM
Gaffer : TRỌNG PHÚC
Equipment & Crew : CINESPACE
Art & Design : NGUYỄN THƯ - LÊ THUẬN
Props : THÀNH CÔNG
Costume : DIRTY COINS - DOTTIE 
Catering :TRÚC PHƯƠNG TEAM
M.U.A : THIÊN TRÚC - HỒNG VÂN
Hair Stylist : RUBY NGUYỄN - LA HUYNH VIEN CHON
Stylist : BUN
Photo Grapher : DUY ANH
BTS : TRƯƠNG MINH - HUBERT HUY HUỲNH
Poster Designer : LÊ ĐĂNG
————————————
Publisher : Yin Yang Media
Social Media : YAN , B3212 Productions , Cổ Động On Air
Sponsored : Dirty Coins
————————————

Link tổng hợp audio trên Spotify, iTunes, Apple Music, NhacCuaTui, Keeng: https://YYM.lnk.to/CDCDS

Tiktok : 
https://vt.tiktok.com/UvJetK/

#andiez #andiezsingmysong #namtruongandiez #andiezchannel #andiezofficial #namtruong
#cdcds  
————————————
☞ SUBSCRIBE Youtube Andiez:  http://bit.ly/andiezofficial
————————————

More about Andiez
☞ Fanpage: https://www.facebook.com/andiezmusic/
☞ Facebook:https://www.facebook.com/andiez95
☞ Instagram: https://www.instagram.com/1m82.5/

————————————

© Bản quyền thuộc về Andiez
© Copyright by Andiez - Do not Reup', N'https://i.ytimg.com/vi/oZIC9M87sLo/maxresdefault.jpg', N'CHỜ ĐỢI CÓ ĐÁNG SỢ | ANDIEZ | OFFICIAL MV', N'2', N'oZIC9M87sLo')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'6CC41D92-5E7E-4789-B2A5-99762E2F776E', N'1', N'2024-11-05 00:18:29.1949087', N'❂ ♬ Yêu Người Có Ước Mơ - buitruonglinh x CaoTri | Lofi Lyrics
Composer: Bùi Trường Linh
Official MV: https://youtu.be/6r7jzy1LABY

𝄞 Lyrics:
Bình minh đến với những mịt mờ
Làm sao thấy đường để tìm thấy nhau
Tự biết sẽ mau xa rời chỉ mình anh với bao nhiêu nghĩ suy
Từ những ánh mắt nụ cười cho cơn gió lạ mà mình mang theo
Đã cuốn đi xa dần biết bao mơ mộng ngày ta có đôi

Nên khẽ đến nhẹ nhàng với một cô gái chưa bao giờ yêu
Là lần đầu tiên em biết tim mình đã rung động
Thế cứ thế từng ngày anh vội vàng khuất xa nơi đại dương
Chẳng thế giữ tay anh lại

Em đã yêu một người có ước mơ
Mơ điều làm em thấy hoang mang lo sợ
Sợ yêu một người không phải như em đã từng
Nếu như anh đi về phía đó liệu rằng anh có còn thấy em
Lệ trong đôi mắt sao mà lấp đi ánh nắng mặt trời

Vẫn yêu dù cho có cô đơn
Dù cho anh không của riêng em sau này
Mộng mơ mà anh ôm lấy sao chẳng có em
Nắng ban mai soi đường anh mãi là hoàng hôn tắt lụi với em
Phải yêu anh cho đến bao giờ em được hạnh phúc riêng mình

Chẳng muốn sau này cứ mãi hy vọng chôn vùi tình em vào cơn bão tố
Đau đến muôn phần anh có đâu hay mình em suy tư mỗi đêm
Lại nhớ thương người không chắc bên nhau một mai khi trời sáng lên
Để rồi ngày hôm nay là ngày mà anh rời xa em

Lỡ yêu một người có ước mơ
Mơ điều làm em thấy hoang mang lo sợ
Sợ yêu một người không phải như em đã từng
Nếu như anh đi về phía đó liệu rằng anh có còn thấy em
Vì lệ trong đôi mắt sao mà lấp đi ánh nắng mặt trời

Đã yêu dù cho có cô đơn
Dù cho anh không của riêng em sau này
Mộng mơ mà anh ôm lấy sao chẳng có em
Nắng ban mai soi đường anh mãi là hoàng hôn tắt lụi với em
Ngàn cơn mưa xuống cho đêm thôi lạnh em thôi bật khóc
Phải yêu anh cho đến bao giờ em được hạnh phúc riêng mình


---------------------------------❁----------------------------------
Connect with buitruonglinh :
➥ SUBSCRIBE TO MY YOUTUBE CHANNEL: https://metub.net/buitruonglinh
➥ Facebook: https://www.facebook.com/buitruonglinhhh
➥ Soundcloud: https://soundcloud.com/b-i-linh-7


❂ Đăng ký kênh giúp CaoTri đạt được nút bạc nhé: https://metub.net/caotri

✿ Follow CaoTri tại:
Facebook: https://www.facebook.com/caotri.prod/
Instagram: https://www.instagram.com/caotri.prod/
Soundcloud: https://soundcloud.com/caotriprod/

✿ Follow meChill tại:
Fanpage: https://www.facebook.com/mechillvn 
YouTube: https://metub.net/mechill
Website: metub.net

Email liên hệ tác quyền và hợp tác phát hành nhạc: mechill@metub.net
---------------------/-----------------
© Bản quyền thuộc về meChill
© Copyright by meChill ☞ Do not Reup
#CaoTri #yeunguoicouocmo #buitruonglinh #lofi', N'https://i.ytimg.com/vi/cJOkT28U4V4/maxresdefault.jpg', N'♬ Yêu Người Có Ước Mơ - buitruonglinh x CaoTri | Lofi Lyrics', N'2', N'cJOkT28U4V4')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'D3F8494F-25B8-4BC0-AEBD-A0C588E2D0EE', N'1', N'2024-11-05 07:25:00.7992512', N'Tham gia làm hội viên của kênh này để được hưởng đặc quyền:
https://www.youtube.com/channel/UCky92hx0lZxVBi2BJ6Zm2Hg/join

👉 Link khóa học backend Go: https://www.youtube.com/playlist?list=PLw0w5s5b9NK6qiL9Xzki-mGbq_V8dBQkY

👉 Link khóa học backend Nodejs: https://www.youtube.com/playlist?list=PLw0w5s5b9NK4ucXizOF-eKAXKvn9ruCw8

👉 Link khóa học backend Java: https://www.youtube.com/channel/UCky92hx0lZxVBi2BJ6Zm2Hg/join
Timeline:
00:00 3 đặc điểm của hệ thống đồng thời cao
02:10 Kịch bán thực tế mở bán vé
04:26 Package by layer vs package by feature
07:50 Code của lập trình viên chưa có kinh nghiệm
15:00 Code của lập trình viên đủ kinh nghiệm

🚩  Subscribe  ➜https://www.youtube.com/c/TipsJavascript
#anonystick #java #backend 
✅  Follow Me:
Blog: https://anonystick.com
Github: https://github.com/anonystick/anonystick
Facebook: https://www.facebook.com/TipJS/
Youtube: https://www.youtube.com/c/TipsJavascript', N'https://i.ytimg.com/vi/EQ4WTurq5I0/maxresdefault.jpg', N'Project bán vé TÀU TẾT: API sập ngày đầu bán vé (CODE TEST) Review CODE với thấy có vấn đề SAI SÓT.', N'0', N'EQ4WTurq5I0')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'6FA2792C-AE36-4ED4-BBAD-A9A0F3D6375D', N'1', N'2024-11-05 00:18:28.3740192', N'Bài hát: Chàng Trai Bất Tử
Sáng tác: Sino
Thể hiện: An Vũ
Pianist: Công Danh
Lyrics:
Và có lẽ hôm nay
Là ngày cuối cùng
Anh sẽ không kêu la
Vì em đến muộn
Đừng khóc như vậy
Làm anh lo lắng đấy
Anh sẽ lau nước mắt
Để em mỉm cười
Ta sẽ bên cạnh nhau
Để ngày sau có nhớ lại
Anh sẽ không thấy ân hận
Anh vẫn muốn được
Ở bên em lần cuối
Từng giờ từng giây trôi
Sẽ chỉ có em mà thôi
Nếu sau này em yếu đuối
Khóc mỗi ngày nhưng không nguôi
Chẳng ai lau giọt nước mắt.
Nhớ đến anh mãi bên cạnh
Có anh đây
Sẽ ôm em ngày em tệ nhất
Có anh đây
Sẽ bên em cùng em
Ngồi mãi trong phòng
Đến khi em đã quên đi
Tình yêu của ta ngày ấy
Anh sẽ đi đời sau ta gặp lại
Đây là lời nhắn cuối cùng anh viết
Chỉ còn nỗi nhớ kể hoài không xiết
Xin lỗi vì để nỗi buồn
Ở trong cuộc đời của em
Sau này anh sẽ luôn đợi trong mơ
Nên là đừng thức đêm nhiều em nhé
Nỗi buồn ngày ấy
Bây giờ để lại rồi đi tiếp thôi
Anh chưa bao giờ
Muốn ôm chặt thế này
Anh sợ phải nghĩ đến
Tim mình đứng lại
Có những điều ta mơ cùng nhau
Giờ chẳng đi được với nhau
Em sẽ phải bước tiếp
Dẫu mình thế nào
Anh vẫn sẽ ở mãi
Trong những kỉ niệm
Lời hứa hôm nay đời sau gặp lại
Có anh đây
Sẽ ôm em ngày em tệ nhất
Có anh đây
Sẽ bên em cùng em
Ngồi mãi trong phòng
Đến khi em đã quên đi
Tình yêu của ta ngày ấy
Anh sẽ đi đời sau ta gặp lại

☞  Hãy nhấn nút SUBSCRIBE/ĐĂNG KÝ Kênh Youtube của mình để nhận những video mới nhất nhé!
More information about An Vu:
Facebook:  https://facebook.com/anvumusic
Tiktok: https://www.tiktok.com/@anvuofficial
✉✉ E-mail: Anvuofficial@gmail.com
-----------------
#AnVu #Sino #ChangTraiBatTu
© Bản quyền thuộc về An Vũ
☞  Không tự ý sử dụng nhạc và video khi không được cho phép.
© Copyright by An Vu', N'https://i.ytimg.com/vi/atkRORFYLyI/sddefault.jpg', N'AN VŨ | Chàng Trai Bất Tử - St: Sino | Piano ver.', N'1', N'atkRORFYLyI')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'22570FE1-3660-490A-A6BE-AADA53848719', N'1', N'2024-11-02 17:15:05.1739603', N'#anhtraivuotnganchonggai #anhtrai #callmebyfire
Hãy đăng ký kênh  @YEAH1SHOW  để cập nhật những thông tin mới nhất từ Anh Trai Vượt Ngàn Chông Gai 2024 nhé mọi người!
----------------------------------------------
Hãy cùng theo dõi và đón chờ những thông tin mới nhất của Anh Trai Vượt Ngàn Chông Gai 2024 trên: 

📍FanPage: https://www.facebook.com/AnhTraiVuotNganChongGai
📍TikTok: https://www.tiktok.com/@anhtraivuotnganchonggai

Chương trình truyền hình thực tế truyền cảm hứng Anh Trai Vượt Ngàn Chông Gai 2024 - CUỘC ĐUA  M NHẠC RỰC "LỬA", TRÍ & TÀI sẽ phát sóng vào thứ 7 hàng tuần lúc 20h trên kênh VTV3 và 20h30 trên YouTube YeaH1 Show từ ngày 29/06/2024.

Anh Trai Vượt Ngàn Chông Gai hứa hẹn tạo nên sự bùng nổ và tạo nên làn sóng giải trí hấp dẫn tại Việt Nam, mang đến màn trình diễn mãn nhãn, mãn nhĩ với những tiết mục trình diễn âm nhạc được dàn dựng công phu và hoành tráng nhất trên sân khấu bậc nhất, cũng như truyền tải năng lượng tích cực đến khán giả Việt Nam trong mỗi tập phát sóng. 

🕺 Các nghệ sĩ góp mặt vào mùa 1 của chương trình, bao gồm: Hồng Sơn, Bằng Kiều, Tự Long, Phan Đinh Tùng, Tuấn Hưng, Đinh Tiến Đạt, Phạm Khánh Hưng, Tiến Luật, Thành Trung, Đăng Khôi, Trương Thế Vinh, Hà Lê, Đỗ Hoàng Hiệp, Thanh Duy, Quốc Thiên, Binz, Cường Seven, Nguyễn Trần Duy Nhất, Jun Phạm, Neko Lê, Tăng Phúc, Thiên Minh, BB Trần, Liên Bỉnh Phát, S.T Sơn Thạch, Rhymastic, Kiên Ứng, (S)TRONG Trọng Hiếu, SOOBIN, Duy Khánh, Kay Trần, Bùi Công Nam, HuyR.
----------------------------------------------
📺 Đón xem Anh Trai Vượt Ngàn Chông Gai 2024 phát sóng từ tháng 29/06/2024 hàng tuần 20h00 trên kênh VTV3 và 20h30 trên YouTube

© Chương trình Anh Trai Vượt Ngàn Chông Gai thuộc bản quyền của YeaH1.', N'https://i.ytimg.com/vi/0VC6euBtKkk/maxresdefault.jpg', N'Có Chàng Trai Viết Lên Cây - Phan Mạnh Quỳnh | MẮT BIẾC OST', N'0', N'0VC6euBtKkk')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'D21D595D-B839-428C-9855-B2E5C60FB13B', N'1', N'2024-11-05 00:18:30.8737648', N'Mãi Mãi Không Phải Anh - Thanh Bình | Official Audio

Composer: Thanh Bình
Produced: Quốc Đạt
Mixed & Mastered: BS16 Production
Video by Iris Nguyen, Dthun

Subscribe now: https://metub.net/thanhbinh

#MaiMaiKhongPhaiAnh #MMKPA #ThanhBinh
----------------
Facebook: https://www.facebook.com/binhhhhhhhh
Instagram: https://www.instagram.com/binhhhhhhhh
Contact: hi.tothanhbinh@gmail.com', N'https://i.ytimg.com/vi/xD8Xchuxq8g/maxresdefault.jpg', N'Mãi Mãi Không Phải Anh - Thanh Bình | Official Audio', N'0', N'xD8Xchuxq8g')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'2D029E2F-5544-46BD-A456-D0DB2A57E661', N'1', N'2024-11-05 07:25:00.5645880', N'Mình đang sử dụng Microsoft Edge và thấy nó quá quá quá ngon. Vậy mà không ai quan tâm. Và trong video hôm nay mình sẽ chia sẻ với các bạn những cách mà mình đang tận dụng Microsoft Edge để các bạn xem rằng nó ngon ở đâu, và sau cùng mình sẽ lý giải vì sao mọi người vẫn dùng Google Chrome nhiều đến như vậy.

0:00 Thị phần microsoft trên thế giới và Việt Nam
0:57 Top tính năng Microsoft Edge
## 1:09 Dọn dẹp 
## 1:26 Đổi Bing sang Google
## 1:44 Nhóm tab
## 2:06 Chuyển tab sang bên cạnh
## 2:29 Chia đôi cửa sổ trình duyệt
## 2:44 Sidebar
## 3:36 PDF trong Edge
## 4:11 Tạo thêm không gian 
## 4:23 Webapps
4:42 Vì sao quá ít người dùng Microsoft edge
## 5:03 Thói quen người dùng
## 5:25 Giao diện mặc định đã xấu
## 5:43 Ban đầu Edge chưa hỗ trợ hết extension
## 6:00 Nhiều tính năng, nhưng mấy ai cần? 
6:17 Anh em đang dùng trình duyệt nào?
_
Follow ThinkView để cùng chia sẻ công nghệ với chúng mình nhé:
- Youtube ThinkView: https://www.youtube.com/ThinkView
- Website ThinkView.vn: https://thinkview.vn/
- Fanpage ThinkView: https://www.facebook.com/thinkview.vn
- Cộng đồng ThinkView & Friends: https://www.fb.com/groups/ThinkView/
- Tiktok ThinkView: https://www.tiktok.com/@thinkview

- Kênh Youtube Hưng Khúc: https://www.youtube.com/@HungKhuc
- Kênh Tiktok Hưng Khúc: https://www.tiktok.com/@hungkhucc
- Facebook Hưng Khúc: https://www.facebook.com/hungquockhuc/

- Cộng đồng Setup góc làm việc tối giản: https://www.facebook.com/groups/setupcungnhau

Bản quyền thuộc về ALPHA & ThinkView
Copyright by ALPHA & ThinkView. Please do not Reup

HỢP TÁC MỜI LIÊN HỆ:
Mobile: Mr. Dương (+84 357252333)
Email: Contact@thealpha.media
Website: https://thealpha.media/

#ThinkView #ALPHA', N'https://i.ytimg.com/vi/X7hh-Yf_I6c/maxresdefault.jpg', N'BUỒN CHO MICROSOFT EDGE: Tính năng rất xịn. Nhưng vì sao người ta vẫn dùng CHROME?', N'0', N'X7hh-Yf_I6c')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'C6D2DE4B-F5BF-434A-A5EE-D186921EADFF', N'1', N'2024-11-05 07:25:04.2232660', N'It was just 2 lovers, 
Sittin in the car 
Listening to Blonde
Fallin for eachother
pink & orange skies,
Feelin super childish
No donald glover 
Missed call from my mother
Like Where u at tonight
Got no alibi
I was all alone

With the love of my life 
Shes got glitter for skin
My Radiant beam in the night
I don''t need no light

To see you shine
It''s your golden hour
You slow down time
In your golden hour

we were just two lovers
Feet up on the dash
Driving nowhere fast 
Burnin through the summer
Radio on blast
make the moment last
She got solar power
Minutes feel like hours
She knew she was the baddest
Can u even imagine 
fallin like I did

For the love of my life 
She''s got glow on her face
A glorious look in her eyes
My angel of light
I was all alone with the love of my life
She''s got glitter for skin
My Radiant beam in the night
I don’t need no light

Official Music Video for "golden hour" by JVKE

STREAM "golden hour": https://jvke.ffm.to/goldenhour

*NEW ALBUM* this is what ____ feels like, out now: https://jvke.ffm.to/whatblankfeelslike

SUBSCRIBE: https://www.youtube.com/channel/UCSOfUqPoqpp5aWDDnAyv94g?sub_confirmation=1

FOLLOW ME ON INSTAGRAM @ITSJVKE: https://www.instagram.com/itsjvke​

FOLLOW ME ON TIKTOK @JVKE: https://www.tiktok.com/@jvke​

FOLLOW ME ON TWITTER @JVKESONGS: https://twitter.com/jvkesongs​

SNAP ME: https://www.snapchat.com/add/imjakela​...

*NEW* MERCH: http://itsjvke.com/#shop​

Director: Gus Black
Executive Producer: Jagger Corcione
Producer: Zena Khafagy
Production Manager: Kevin Douglas
DP: David Merino
1st AD: Deighton Mckoy
1st AC: Kyle Isler
Gaffer: Nate Airey
Key Grip: Chandler Joseph Bado
Swing: Jess Zambrano
MUA: Amrita Mehta
Groomer: Tatiana Mendez
PA: Sabrina Alvarez
PA: Daniel Figueroa
Editor: Gus Black
Prod Co: 5 Towns Media House
Video Commissioner: Bianca Bhagat @ AWAL
VP, Marketing: Justin Macchio @ AWAL
Label: AWAL
Management: Ethan Curtis, Aton Ben-Horin @ Plush Management 
Directors Representative:  Kelly Norris Sarno @ Agency Arts

#JVKE #goldenhour #officialvideo', N'https://i.ytimg.com/vi/PEM0Vs8jf1w/maxresdefault.jpg', N'JVKE - golden hour (official music video)', N'0', N'PEM0Vs8jf1w')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'DF75E1E1-F64B-49A9-AF35-D83F584733DE', N'1', N'2024-11-05 07:25:01.0183965', N'Tham gia làm hội viên của kênh này để được hưởng đặc quyền:
https://www.youtube.com/channel/UCky92hx0lZxVBi2BJ6Zm2Hg/join

👉 Link khóa học backend Go: https://www.youtube.com/playlist?list=PLw0w5s5b9NK6qiL9Xzki-mGbq_V8dBQkY

👉 Link khóa học backend Nodejs: https://www.youtube.com/playlist?list=PLw0w5s5b9NK4ucXizOF-eKAXKvn9ruCw8

👉 Link khóa học backend Java: https://www.youtube.com/channel/UCky92hx0lZxVBi2BJ6Zm2Hg/join
Timeline: 
01:20 Tối ưu phân trang theo Google
03:10 Cú pháp phân trang MYSQL
12:07 Mẹo tạo INDEX dựa trên tiêu chí 
14:30 Sau khi tối ưu 7s còn 1 s

🚩  Subscribe  ➜https://www.youtube.com/c/TipsJavascript
#anonystick #mysql #backend 
✅  Follow Me:
Blog: https://anonystick.com
Github: https://github.com/anonystick/anonystick
Facebook: https://www.facebook.com/TipJS/
Youtube: https://www.youtube.com/c/TipsJavascript', N'https://i.ytimg.com/vi/tjT4O5HGIEU/maxresdefault.jpg', N'MYSQL BACKEND: Tối ưu hoá phân trang từ 7s còn 1s với Table có 10.000.000 dữ liệu, SẾP tăng lương...', N'1', N'tjT4O5HGIEU')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'51A2CE79-DB1A-47BB-A29D-D915EF3B6F7C', N'1', N'2024-11-13 16:23:37.4432807', N'Với phương châm "Uy tín là sự nghiệp", sonhainguyen.com chuyên cung cấp các gói YouTube Premium giúp bạn xem YouTube không còn quảng cáo, với mức giá cực kỳ hấp dẫn chỉ 365k/năm. Uy tín và chất lượng luôn là mục tiêu hàng đầu của chúng tôi!
website: sonhainguyen.com
-----------------
Mới đây nhất việc ông Donald Trump đắc cử Tổng thống thứ 47 của Hoa Kỳ đã làm tốn không ít giấy mực của các nhà báo. Người ta có vẻ mong chờ và đưa ra những dự đoán về chính sách của ông Trump, nổi tiếng là con người thực dụng và có phần hiếu chiến

▶ TỪ NGHỊCH LÝ TRÊN CHIẾN TRƯỜNG UKRAINE CHO TỚI NGHỆ THUẬT PHÁO BINH ĐỈNH CAO CỦA VIỆT NAM
https://youtu.be/8HaxRN6LLi0
▶ TƯƠNG LAI TĂM TỐI CỦA KÊNH ĐÀO PHÙ NAM - LIÊN TỤC CHẬM TIẾN ĐỘ, NGUỒN VỐN THIẾU HỤT VÀ BẾ TẮC
https://youtu.be/AOsiUbYBNr8
▶ NHÌN VÀO UKRAINE VÀ TẤM GƯƠNG VNCH ĐỂ THẤY CÁI GIÁ CỦA SỰ PHỤ THUỘC LÀ THÊ THẢM NHƯ THẾ NÀO?
https://youtu.be/Jes4grQnmSo
▶ VIỆT NAM ĐÃ NÉ CÁI "BÁNH VẼ" SIÊU TO KHỔNG LỒ CỦA TẬP ĐOÀN INTEL NHƯ THẾ NÀO?
https://youtu.be/X4KeiC8SshY
▶ TÂN TỔNG THỐNG MỸ DONALD TRUMP SẼ THAY ĐỔI CỤC DIỆN TRANH CHẤP BIỂN ĐÔNG THẾ NÀO
https://youtu.be/JSYEYFcCXP0
▶ BANGLADESH LẠI BIỂU TÌNH CỰC KỲ HỖN LOẠN VÀ CÁCH MÀ VIỆT NAM TỪNG XỬ LÝ TRONG QUÁ KHỨ
https://youtu.be/_NH7WJgVcEo
▶ BẦU CỬ TỔNG THỐNG MỸ 2024 ẢNH HƯỞNG THẾ NÀO TỚI VIỆT NAM? DONALD TRUMP HAY KAMALA HARRIS?
https://youtu.be/wkMZrGxKZrE

Fanpage chính thức: https://www.facebook.com/battlecry.nguoikesu

Một số tư liệu được sử dụng trong video thuộc về các chủ sở hữu đáng kính. Mọi vấn đề liên quan đến bản quyền, vui lòng liên hệ: battlecry.vn@gmail.com.
Some of the materials used in the video belongs to the rightful owners. All Copyrights related issues should be sent to battlecry.vn@gmail.com. Thank you.

#battlecry #lichsu #chientranhvietnam #lichsuvietnam', N'https://i.ytimg.com/vi/9OVVle8ilp8/maxresdefault.jpg', N'TBT TÔ LÂM ĐIỆN ĐÀM DONALD TRUMP - DỰ BÁO VỀ 1 "CÚ SHOCK" NGOẠI GIAO ĐỈNH CAO CỦA VIỆT NAM?', N'0', N'9OVVle8ilp8')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'C11B31BC-A647-4D80-B598-DE4565B8B77A', N'1', N'2024-11-05 07:25:03.8475072', N'Đường Tôi Chở Em Về - buitruonglinh | Lyrics Video |
---------------------------------------------------
25/1/2020
Gần tròn 4 năm kể từ ngày tôi lấy hết can đảm ra mà nói lời yêu em.

Hồi ấy hai chúng tôi cùng chung một lớp, suốt cả năm 12 tôi đều chở em đi học , ngày nào cũng vậy, vẫn một con đường ấy dù là ban ngày hay cho trời có chuyển tối.

Thời gian thì cứ trôi qua những ngày bình thường như thế thôi.
Rồi cũng tới lúc chúng tôi sắp phải thi đại học, tôi hiểu được phần nào những áp lực mà em phải chịu đựng.

Có những hôm trên đường về em bật khóc, tôi thương em nhiều lắm, chỉ biết làm mấy trò cũ chọc em cười, nhưng trong lòng thì vẫn cứ vẩn vơ nhiều thứ. Dần dà , thành ra tôi lại mang trong mình một nỗi sợ.

Tháng 5 thì cũng đã là giữa mùa hạ rồi, không biết rồi tôi còn được chở em đi về thêm bao nhiêu lần nữa đây? 

https://open.spotify.com/album/11usBN9oLbxkDegtx4ilUW

Written by buitruonglinh
Vocals by buitruonglinh
Producer : Đinh Tuấn Anh 
Mixing & Mastering: Lý Anh Khoa
--------------------------------------------------
Connect with buitruonglinh :
➥ SUBSCRIBE TO MY YOUTUBE CHANNEL: https://metub.net/buitruonglinh
➥ Facebook: https://www.facebook.com/buitruonglinhhh
➥ Soundcloud: https://soundcloud.com/b-i-linh-7
➥ Gmail: buitruonglinhsg@gmail.com 
---------------------------------------------------
© Bản quyền thuộc về buitruonglinh
© Copyright by buitruonglinh ☞ Do not Reup

Xin cảm ơn tất cả mọi người đã lắng nghe  !!!
#duongtoichoemve #buitruonglinh', N'https://i.ytimg.com/vi/OuNo8Tkb3lI/maxresdefault.jpg', N'Đường Tôi Chở Em Về / buitruonglinh | Lyrics Video |', N'0', N'OuNo8Tkb3lI')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'AF0AF557-2136-4881-B7D4-DF4AE110203D', N'1', N'2024-11-05 00:18:30.6127894', N'Anh Thương Em Nhất Mà? - Lã. x Log x TiB / OFFICIAL
Sáng tác: Lã.
Vocal: Log
Rap: TiB
Piano: Lã.
Thu âm và chỉnh sửa: VuHoaiSon/ HS Studio
#anhthuongemnhatma #atenm #chang #La #Tib #log

💛 Follow Lã.:
Facebook: https://www.facebook.com/lathuytrang16
soundcloud: https://soundcloud.com/l-thu-trang-14995540

---------------------
🔔 Note:
* Chỉ đơn giản rằng Chang chia sẻ các bài hát mà có thể bạn chưa bao giờ được nghe.
* Nếu có bất cứ thắc mắc, khiếu nại nào về bản quyền hình ảnh cũng như âm nhạc có trong video mong chủ sở hữu liên hệ trực tiếp qua thông tin bên dưới
* Nhận phát hành các bản lo-fi, Indie, nhạc chill... chỉ cần phù hợp với channel là Support liền ^^
💛 Follow Chang:
https://www.facebook.com/Fansite.Anhs
https://www.youtube.com/changacoustic
https://www.instagram.com/vuanh.chang/
Email: vuanh.ceto@gmail.com

---------------------
🎧 Lyrics: 

Ngược dòng thời gian quay về quá khứ
Anh tìm lại những kí ức hôm nào
Lục tìm trong trí nhớ ngày đầu thu
Anh mỉm cười nhớ bóng dáng của em
Ngày em đến bên anh là món quà
Anh thầm ước nguyện từ bấy lâu
Ngày em đến bên anh là ánh dương
Mang tình yêu ngập tràn nơi anh

Anh thương em nhất mà
Cớ sao bây giờ lại vội chia xa
Anh yêu em nhất mà
Cớ sao bây giờ lại vội buông tay
Từng day dứt ngày ấy vẫn luôn vẹn nguyên tình mình tựa mây bay
Lời theo gió nhẹ trôi tiếng yêu đầu môi lụi tàn nào ai hay

Có người hỏi sao anh lại viết nhạc
Vì khó quên em nên không thể làm việc khác
Cớ sao anh luôn bên phím đàn
Vì nỗi nhớ em luôn tích tịch tình tang
Chuyện tình đẹp hay chuyện tình dở dang
Tình mình có thơ hay chỉ là lỡ làng
Tình mình giống như nàng Kiều và Kim Trọng
Bắt đầu thật đẹp để rồi toàn thở than
Anh đã có cho mình những sai lầm
Chất thành đống nên giờ thật khó sửa
Từ khi xa em nỗi nhớ tới làm bạn
Còn đêm nay nỗi buồn đến gõ cửa.
Anh tua ngược bộ phim của kí ức
Để một lần nữa sống trong kỉ niệm xưa
Tìm một ngày được bên nhau lần nữa
Sao khó như tìm hạt nắng trong vệt mưa.
Khu vườn tình yêu không chăm sóc
Chỉ còn cành khô và vài nắm cỏ dại
Làm sao để lau mi em khóc
Làm sao để tình mình thắm trở lại?
Anh không muốn cuộc sống mình vô vị
Như Tô Thị hóa đá chờ nghìn năm
Anh chỉ muốn làm cao áp đô thị
Nơi em tối thì anh tới hỏi thăm.
Xa em rồi anh sẽ nhớ
Nhớ lần đầu đôi mình khẽ chạm môi
Nhớ cả cái nắm tay chiều hôm ấy
Nhớ cả những cái ôm mới đây thôi.
Anh vẫn có cho mình những câu hỏi
Về chuyện tình của hai ta
Rằng anh thương em nhất mà
Cớ sao bây giờ mình phải vội chia xa?

---------------------------
⛔ © 2020 Chang', N'https://i.ytimg.com/vi/ZgRNBvSLsRc/sddefault.jpg', N'Anh Thương Em Nhất Mà? - Lã. x Log x TiB / OFFICIAL', N'0', N'ZgRNBvSLsRc')
GO

INSERT INTO [dbo].[Video] ([id], [active], [createdTime], [description], [poster], [title], [views], [youtubeId]) VALUES (N'1533D27E-F776-4FFD-A41B-F5F96B5B3B12', N'1', N'2024-11-05 07:25:02.7090725', N'Có những người có IQ rất cao, nghĩa là họ rất thông minh, nhưng EQ của họ lại thấp, khiến cho cuộc sống xã hội hay các mối quan hệ của họ trở nên phức tạp. Họ có thể không nhận ra mình đang gặp vấn đề, vì từ trước đến giờ họ luôn được khen ngợi về sự thông minh, nhưng họ lại gặp khó khăn trong việc giao tiếp với người khác.', N'https://i.ytimg.com/vi/1RsQRv01m_4/maxresdefault.jpg', N'Dấu hiệu bạn có IQ CAO nhưng EQ THẤP', N'0', N'1RsQRv01m_4')
GO


-- ----------------------------
-- Indexes structure for table Favourite
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [UK3694rgqcvtxysc1argfhlupf7]
ON [dbo].[Favourite] (
  [userId] ASC,
  [videoId] ASC
)
WHERE ([userId] IS NOT NULL AND [videoId] IS NOT NULL)
GO


-- ----------------------------
-- Uniques structure for table Favourite
-- ----------------------------
ALTER TABLE [dbo].[Favourite] ADD CONSTRAINT [Favourite_unique] UNIQUE NONCLUSTERED ([userId] ASC, [videoId] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Favourite
-- ----------------------------
ALTER TABLE [dbo].[Favourite] ADD CONSTRAINT [PK__Favourit__3213E83F159C57C9] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table Share
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [UK2le9y9v18tjgf550cu9pdlqyu]
ON [dbo].[Share] (
  [userId] ASC,
  [videoId] ASC
)
WHERE ([userId] IS NOT NULL AND [videoId] IS NOT NULL)
GO


-- ----------------------------
-- Primary Key structure for table Share
-- ----------------------------
ALTER TABLE [dbo].[Share] ADD CONSTRAINT [PK__Share__3213E83F1373A358] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Users
-- ----------------------------
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [PK__Users__3213E83FEE546911] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Video
-- ----------------------------
ALTER TABLE [dbo].[Video] ADD CONSTRAINT [PK__Video__3213E83FA6E1A9B6] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table Favourite
-- ----------------------------
ALTER TABLE [dbo].[Favourite] ADD CONSTRAINT [FKiqpiliylytb8bqwxhdxumhep9] FOREIGN KEY ([userId]) REFERENCES [dbo].[Users] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[Favourite] ADD CONSTRAINT [FKpvvwxn1jkjyfwjavbgx4qkyax] FOREIGN KEY ([videoId]) REFERENCES [dbo].[Video] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Share
-- ----------------------------
ALTER TABLE [dbo].[Share] ADD CONSTRAINT [FKsvsnlevgkbw26eg2bh0ba9nsv] FOREIGN KEY ([userId]) REFERENCES [dbo].[Users] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[Share] ADD CONSTRAINT [FKi6xu21f4bjhriem32kcemaw7c] FOREIGN KEY ([videoId]) REFERENCES [dbo].[Video] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

