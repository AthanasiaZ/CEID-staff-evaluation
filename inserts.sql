INSERT `CEID-Staff-Evaluation`.`company` (`AFM`, `DOY`, `name`, `phone`, `street`, `num`, `city`, `country`)
VALUES
('123456789', 'PYRGOU', 'Vassae', 2621012345, 'MANOLOPOULOU', 32, 'PYRGOS', 'GREECE'),
('012345345', 'A PATRON', 'Citrix', 2610123456, 'MIAOULI', 27, 'PATRAS', 'GREECE'),
('901234567', 'B XOLARGOU', 'Accenture', 2101234567, 'ZAKYNTHOU', 101, 'ATHENS', 'GREECE'),
('555554444', 'D THESSALONIKIS', 'TaskUs', 2310123456, 'ATTIKIS', 06, 'THESSALONIKI', 'GREECE')
;

INSERT `CEID-Staff-Evaluation`.`user` (`username`, `password`, `name`, `surname`, `regDate`, `email`)
VALUES

/*managers*/
('paraskevi99', 'OnePiece', 'Paraskevi', 'Apostolopoulou', '2011-11-11 11:11:11', 'paraskevi99@gmail.com'),
('anaksiman', '12101982a', 'Anaksimandros', 'Tsiridemoglou', '2018-02-23 18:10:42','anaksimandrostsi@yahoo.com'),
('dionysus04', '@dion2004', 'Dionisis', 'Makris', '2015-04-19 19:12:17', 'dionysus04@gmail.com'),

/*evaluators*/
('fotisz', 'RIPChewbacca', 'Fotios', 'Zafeiris', '2012-02-03 12:02:03', 'fotisz@yahoo.com'),
('pelagiakou', 'kWdIkOs123', 'Pelagia', 'Kouroumpela', '2014-07-03 14:12:57', 'pelagiakou@hotmail.com'),
('elenitsa9', 'abc0001', 'Eleni', 'Georgiou', '2013-08-17 09:12:33', 'elenitsa09@gmail.com'),

/*employees*/
('afroditimy', 'denksexno', 'Afroditi', 'Milou', '2015-01-01 20:20:03', 'afroditi0603@gmail.com'),
('petrospap', 'spongebob', 'Petros', 'Papadis', '2015-02-03 17:02:44', 'petrakos@hotmail.com'),
('apanag', '123456789pa', 'Aristeidis', 'Panagopoulos', '2016-04-27 12:35:36', 'panagopoulosaris@yahoo.com'),
('matinaakrivi', 'PastitsiO12', 'Stamatia', 'Akrivi', '2012-01-17 09:03:12', 'matinaakrivi93@gmail.com'),

/*admin*/
('xrysavellou', '14sept1991x', 'Xrisopigi', 'Vellou', '2013-03-19 10:10:05', 'xrysavellou@gmail.com')
;

INSERT `CEID-Staff-Evaluation`.`manager` (`managerUsername`, `experience`, `firm`)
VALUES
('paraskevi99', 9, '555554444'),
('anaksiman', 3, '901234567'),
('dionysus04', 6, '123456789')
;

INSERT `CEID-Staff-Evaluation`.`evaluator` (`username`,`experience`, `firm`, `evaluatorID`)
VALUES
('fotisz', 9, '555554444', 0000000001),
('pelagiakou', 7, '901234567', 0000000002),
('elenitsa9', 8, '012345345', 0000000003)
;

INSERT `CEID-Staff-Evaluation`.`employee` (`username`, `firm`, `resume`, `sistatikes`, `certificates`, `awards`)
VALUES
('afroditimy', '555554444', 'CVMilou.pdf', 'RecommendationsMilou.pdf', 'CertificatesMilou.pdf', 'AwardsMilou.pdf'),
('petrospap', '901234567', 'CVPapadis.pdf', 'RecommendationsPapadis.pdf', 'CertificatesPapadis.pdf', 'AwardsPapadis.pdf'),
('apanag', '123456789', 'CVPanagopoulos.pdf', 'RecommendationsPanagopoulos.pdf', 'CertificatesPanagopoulos.pdf', 'AwardsPanagopoulos.pdf'),
('matinaakrivi', '123456789', 'CVAkrivi.pdf', 'RecommendationsAkrivi.pdf', 'CertificatesAkrivi.pdf', 'AwardsAkrivi.pdf')
;

INSERT `CEID-Staff-Evaluation`.`degree` (`title`, `institution`, `bathmida`)
VALUES
('Computer Engineering and Informatics', 'University of Patras', 'UNI'),
('Dynamic Programming, Greedy Algorithms', 'University of Colorado', 'UNI'),
('Computer Vision and Modelling', 'Princeton University', 'MASTER'),
('High Efficiency Algorithms', 'University of Patras', 'PHD'),
('Lyceum certificate', '1st Lyceum of Patras', 'LYKEIO')
;

INSERT `CEID-Staff-Evaluation`.`has_degree` (`title`, `institution`, `emplUsername`, `etos`,  `grade`)
VALUES
('Computer Engineering and Informatics', 'University of Patras', 'apanag', 2009, 7.6),
('Dynamic Programming, Greedy Algorithms', 'University of Colorado', 'matinaakrivi', 2004, 8),
('Computer Vision and Modelling', 'Princeton University', 'apanag', 2011, 8.2),
('Lyceum certificate', '1st Lyceum of Patras', 'petrospap', 2013, 19.3),
('High Efficiency Algorithms', 'University of Patras', 'matinaakrivi', 2007, 8.3),
('Computer Engineering and Informatics', 'University of Patras', 'afroditimy', 2012, 6.9)
;

INSERT `CEID-Staff-Evaluation`.`project` (`employee`,  `descr`, `url`)
VALUES
('afroditimy', 'A scrutny about ISE', 'https://github.com/afroditimy/ISE'),
('afroditimy', 'Secure VPN access for remote workers', 'https://github.com/afroditimy/AnyConnect'),
('petrospap', 'Application Programming Inteface connection to random website', 'https://github.com/petrospap/APIrandom'),
('petrospap',  'SQL based Crud Web Application', 'https://github.com/petrospap/CRUDrandom'),
('apanag', 'Holistic Platform Design for Smart Buildings of the Future Internet', 'https://github.com/apanag/hobnet'),
('apanag', 'Research extending IoT testbed for multidisciplinary experiments', 'https://github.com/apanag/IoT'),
('apanag', 'Crowd-sourcing based privacy protection for web applications', 'https://github.com/apanag/randomPrivacysetup'),
('matinaakrivi', 'Population-Based Optimization Algorithms', 'https://github.com/matinaakrivi/stuff')
;

INSERT `CEID-Staff-Evaluation`.`job` (`ID`,  `startDate`, `salary` , `position`, `edra`, `evaluator`, `announcement_date`, `expiration_date`)
VALUES
(0001, '2021-01-01', 1400, 'web programmer', '555554444', 'fotisz', '2020-10-01', '2020-12-30'),
(0002, '2021-02-02', 1800, 'graphics designer', '555554444', 'fotisz', '2020-11-02', '2021-01-30'),
(0003, '2021-03-03', 2100, 'visualization expert', '555554444', 'fotisz', '2020-12-03', '2021-02-30'),
(0004, '2021-04-04', 1250, 'web programmer', '012345345', 'elenitsa9', '2021-01-04', '2021-03-04'),
(0005, '2021-05-05', 2000, 'AI expert', '901234567', 'pelagiakou', '2021-02-05', '2021-04-05'),
(0006, '2021-06-06', 1950, 'Algorithmic efficiency tester', '901234567' , 'pelagiakou', '2021-03-06', '2021-05-06')
;

INSERT `CEID-Staff-Evaluation`.`antikeim` (`title`, `descr`, `parentField`)
VALUES
('Computer Science', 'root', NULL),
('Databases' , 'level1', 'Computer Science'),
('Algorithms', 'level1', 'Computer Science'),
('Graphics', 'level1', 'Computer Science'),
('AI', 'level1', 'Computer Science'),
('2D', 'level2', 'Graphics'),
('3D', 'level2', 'Graphics'),
('Animation', 'level2', 'Graphics'),
('Robotics', 'level2', 'AI'),
('Web programming', 'level1', 'Computer Science')
;

INSERT `CEID-Staff-Evaluation`.`needs` (`jobID`, `fieldTitle`)
VALUES
(0001, 'Web programming'),
(0001, 'Databases'),
(0002, 'Graphics'),
(0003, 'Graphics'),
(0003, '2D'),
(0003, '3D'),
(0004, 'Web programming'),
(0005, 'AI'),
(0005, 'Robotics'),
(0006, 'Algorithms')
;

INSERT `CEID-Staff-Evaluation`.`request_evaluation` (`emplUsername`, `jobID`)
VALUES
('afroditimy', 0001),
('afroditimy', 0006),
('petrospap', 0001),
('petrospap', 0004),
('apanag', 0005),
('apanag', 0002),
('apanag', 0003),
('matinaakrivi', 0005)
;

INSERT `CEID-Staff-Evaluation`.`evaluation` (`evaluationID`,`emplUsername`, `evalUsername`, `jobID`, `interviewGrade`, `reportGrade`, `recGrade`,`finalGrade`, `comments`, `completed`)
VALUES
(1, 'afroditimy', 'fotisz', 0001, 7, 8.5, 6.5, 7.5, 'Very Good', 1),
(2, 'afroditimy', 'pelagiakou', 0006, 4, 9, NULL, NULL, 'Not confident, great report', 0),
(3, 'petrospap', 'fotisz', 0001, 10, 9, 9, 9.5, 'Excellent', 1),
(4, 'petrospap', 'elenitsa9', 0004, 9, 8, 9, 9, 'Excellent', 1),
(5, 'apanag', 'pelagiakou', 0005, NULL, NULL, NULL, NULL, NULL, 0),
(6, 'apanag', 'fotisz', 0002, 3, 4, 3, 3.5, 'Rude and incompetent', 1),
(7, 'apanag', 'fotiz', 0003, 8, 9, 9, 9, 'Surprisingly great', 1),
(8, 'matinaakrivi', 'pelagiakou', 0005, 7, 8, 9, 8, 'Great', 1)
;

INSERT `CEID-Staff-Evaluation`.`languages` (`employee`, `language`)
VALUES
('afroditimy', 'EN, FR, GR'),
('petrospap', 'EN, GR'),
('apanag', 'EN, SP, GR'),
('matinaakrivi', 'EN, RU, GR')
;
