# partitioning-table-inheritance

In order to facilitate the necessary database modifications, the sequence for executing scripts is as follows:

1. `accounts_changes.sql`
2. `cards_changes.sql`
3. `table_address_type.sql`
4. `address_type.sql`
5. `users_changes.sql`
6. `fixing_users_data.sql`
7. `transactions_table_transformation.sql`
8. `transactions_data_move.sql`
9. `table_rename.sql`
10. `partition_function.sql`
11. `adding_accounts_relations.sql`

**Useful Notes:**
- The project is divided into three distinct sections: `data_loading`, `schema_changes`,`db_diagrams` and `testing_script`, each serving its designated purpose. The `testing_script` contains scripts designed to validate index usage.
- Instead of removing Unix timestamp columns (`created` and `updated`) from all tables, a new generated column with a more human-readable timestamp format has been introduced wherever necessary. If Unix timestamp columns are unnecessary, they can be removed.The decision to retain these Unix timestamp columns was driven by the assumption that our data consistently arrives in Unix timestamp format.
- To handle different address types, the `address_type` table has been introduced with relevant relationships to other tables. Additionally, an `address_category` type (ENUM) has been implemented, which can be further modified to accommodate additional address types.
- Foreign key and primary key relationships, as well as indexes, are not automatically propagated to new partitions via inheritance. To address this, modifications have been made in the partition creation function to include necessary foreign keys, primary keys, and indexes whenever a new partition is created.
- As a solution to the mentioned point, an index named `round_amount_idx_` followed by the table name will be automatically incorporated upon the creation of each new partition.
- For comprehensive information regarding the partitioning function and trigger, refer to the transactions_table_transformation.sql script.
