

/* 1 */

select count(c.name), c.name
from clinic c
join healthCenter_clinic hc_c
on c.id = hc_c.clinic_id
join clinic_preview cp on hc_c.id = cp.health_center_clinic_id

group by c.name
having count(c.name) > (
							select count(c.name)
							from clinic c
							join healthCenter_clinic hc_c
							on c.id = hc_c.clinic_id
							join clinic_preview cp on hc_c.id = cp.health_center_clinic_id
							where c.name = 'aie'
							group by c.name
						);


/* 2 */

select hc.name
from health_center hc
join healthCenter_service hc_s on hc.id = hc_s.healthyCenter_id
join health_service hs on hs.id = hc_s.service_id
where hc.name not in (
					select hc.name
					from health_center hc
					join healthCenter_service hc_s on hc.id = hc_s.healthyCenter_id
					join health_service hs on hs.id = hc_s.service_id
					where hs.name = 'huamel'
				 );


/* 3 */


select count(hc.name), hc.name
from health_center hc
join healthCenter_clinic hc_c on hc.id = hc_c.healthyCenter_id
join clinic_preview cp on hc_c.id = cp.health_center_clinic_id
group by hc.name
having count(hc.name) > 1000;


/* 4 */


select COUNT(temp.c), temp.c from
(select COUNT(c.name) a, c.name b, p.name c
from clinic c
join healthCenter_clinic hc_c
on c.id = hc_c.clinic_id
join clinic_preview cp on hc_c.id = cp.health_center_clinic_id
join patient p on p.id = cp.patient_id
group by c.name, p.name ) as temp

group by temp.c

having COUNT(temp.c) = 1;


/* 5 */

USE [health-center-db]
GO

/****** Object:  Table [dbo].[patient_form]    Script Date: 5/20/2019 2:39:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[patient_form](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[patient_id] [int] NOT NULL,
	[health_center_service_id] [int] NOT NULL,
	[visite_date] [datetime] NOT NULL,
 CONSTRAINT [PK_patient_form] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[patient_form]  WITH CHECK ADD  CONSTRAINT [FK_patient_form_healthCenter_service] FOREIGN KEY([health_center_service_id])
REFERENCES [dbo].[healthCenter_service] ([id])
GO

ALTER TABLE [dbo].[patient_form] CHECK CONSTRAINT [FK_patient_form_healthCenter_service]
GO

ALTER TABLE [dbo].[patient_form]  WITH CHECK ADD  CONSTRAINT [FK_patient_form_patient] FOREIGN KEY([patient_id])
REFERENCES [dbo].[patient] ([id])
GO

ALTER TABLE [dbo].[patient_form] CHECK CONSTRAINT [FK_patient_form_patient]
GO
