///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО Фобизнес ПРО
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Функция - Определить все возможные свойства и настройки методов заложенные в API протокола WITSML
// Из полученной таблицы будут отбираться доступные для нашего сервиса
// 
// Возвращаемое значение:
//  ТаблицаЗначений - Содержит все методы их свойства и настройки
//
Функция ОпределитьНастройкиМетодов() Экспорт
	
	тзНастройкиДоступныхПолейМетодов = Новый ТаблицаЗначений;
	
	Макет = ПолучитьОбщийМакет("РаботаСGTIOnlineМакет");
	
	Если Макет.Области.Количество() = 0 Тогда
		
		ЗаписьЖурналаРегистрации(НСтр("ru='Не найден макет заполнения для работы с GTI-Online.'"), 
		УровеньЖурналаРегистрации.Ошибка,
		Метаданные.ОбщиеМакеты.РаботаСGTIOnlineМакет);
		
		Возврат тзНастройкиДоступныхПолейМетодов;
		
	КонецЕсли;
	
	ПостроительОтчета = Новый ПостроительОтчета;                                    
	ПостроительОтчета.ИсточникДанных = Новый ОписаниеИсточникаДанных(Макет.Области[0]);
	ПостроительОтчета.Выполнить();
	тзНастройкиДоступныхПолейМетодов = ПостроительОтчета.Результат.Выгрузить();
	
	Возврат тзНастройкиДоступныхПолейМетодов;
	
КонецФункции

// Функция - Определить настройки запроса к методу по шаблону
//
// Параметры:
//  СтруктураПолученияЗапроса	 - Структура - Параметры запроса и тип запроса для сервиса.
// 
// Возвращаемое значение:
//  Структура - Параметры заполнения страницы формы "Настройка"
//    * WMLtypeIn - Строка - Тип запроса для сервиса.
//    * QueryIn   - Строка - Текст запроса для исполнения сервисом.
//
Функция ОпределитьНастройкиЗапросаКМетоду_ПоШаблону(СтруктураПолученияЗапроса) Экспорт
	
	СтруктураОтвета = Новый Структура("WMLtypeIn, QueryIn");
		
	Макет = ПолучитьОбщийМакет("РаботаСGTIOnline_ШаблоныЗапросов");
	
	НайденнаяОбласть = Макет.Области.Найти(СтруктураПолученияЗапроса.Значение_WMLtypeIn); 
	Если НайденнаяОбласть = Неопределено Тогда 
		ЗаписьЖурналаРегистрации(НСтр("ru='Не найден макет с шаблонами запросов для работы с GTI-Online.'"), 
		УровеньЖурналаРегистрации.Ошибка,
		Метаданные.ОбщиеМакеты.РаботаСGTIOnline_ШаблоныЗапросов);	
		
	Иначе
		СтруктураОтвета.Вставить("WMLtypeIn", СтруктураПолученияЗапроса.Значение_WMLtypeIn);
		СтруктураОтвета.Вставить("QueryIn", СтрШаблон(НайденнаяОбласть.Текст, СтруктураПолученияЗапроса.Парам1, СтруктураПолученияЗапроса.Парам2));
		
	КонецЕсли;
	
	Возврат СтруктураОтвета;	
	
КонецФункции	

#КонецОбласти
