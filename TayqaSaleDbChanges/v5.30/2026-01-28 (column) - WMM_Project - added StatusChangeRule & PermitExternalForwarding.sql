ALTER TABLE WMM_Project
    ADD PermitExternalForwarding bit default 0 not null,
        StatusChangeRule tinyint default 1 not null

GO