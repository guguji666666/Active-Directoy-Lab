## Configure Windows firewall rule using Domain GPO

"Windows Firewall: Domain: Firewall State" is a Group Policy setting in Microsoft Windows that allows network administrators to configure the Windows Firewall behavior on domain-connected Windows computers.

Therefore, it's crucial to ensure that the Windows Firewall is enabled and configured properly on all domain-connected Windows computers to maintain the security and integrity of the network. Administrators should regularly review and update firewall policies to ensure that any changes align with the organization's security objectives and policies.

### To enable the domain firewall using group policy settings, please follow these steps:

1. Open the Group Policy Management Console (GPMC) on your domain controller.

2. Create a new Group Policy Object (GPO) or edit an existing one.

3. Navigate to `Computer Configuration > Policies > Windows Settings > Security Settings > Windows Firewall with Advanced Security > Windows Firewall with Advanced Security - LDAP://cn={GUID},cn=policies,cn=system,DC=domain,DC=com`

![image](https://user-images.githubusercontent.com/96930989/230535552-d00d800a-648d-4d07-b9a7-3de99a47c5d6.png)

4.In the right pane, click `Windows Defender Firewall Properties`

5. Under Firewall state, select On (recommended).

6. Under Inbound connections, select Block (default).

7. Under Outbound connections, select Allow (default).

8. Click OK to save the changes.

![image](https://user-images.githubusercontent.com/96930989/230535642-6004fbfd-9dcc-424f-91cf-0d1383034a6a.png)

Once the group policy settings have been applied to the domain, the domain firewall will be enabled on all computers that are joined to the domain.
