# Supabase Codegen

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

Supabase Codegen generates type-safe Dart models from your Supabase tables automatically!

## Installation 💻

**❗ In order to start using Supabase Codegen you must have the [Dart SDK][dart_install_link] installed on your machine.**

Add the following to your pubspec.yaml

```yaml
dev_dependencies:
  supabase_codegen:
    git:
      url: https://github.com/Khuwn-Soulutions/supabase_codegen.git
      ref: main
```

---

## ✨ Features

- Automatically generates Dart classes from Supabase tables
- Creates type-safe models with full IDE support
- Supports complex relationships and nested structures
- Generates getters and setters for all fields

## 📋 Prerequisites

- Supabase project with tables
- Dart/Flutter development environment
- Environment configuration file (`.env`)

## 🛠️ Setup

1. Install the package. See [Installation](#installation-)
2. Create a `.env` file at the root of your project with your Supabase credentials. See [example.env](example.env).
3. Create SQL functions in Supabase.  
   Options:
   - Copy and run the sql from [get_schema_info](bin/sql/get_schema_info.dart) and [get_enum_types](bin/sql/get_enum_types.dart) in your Supabase project.
   - Create migration to apply to your local or remote database with `dart run supabase_codegen:add_codegen_functions` and apply the migration with [`supabase migration up`](https://supabase.com/docs/reference/cli/supabase-migration-up).  
   Note: this requires [Supabase CLI](https://supabase.com/docs/reference/cli/introduction) with linked project

4. Run the generation script: 

```bash 
dart run supabase_codegen:generate_types
```  

## Command Line Options  

You can customize the type generation process with the following command-line options:

- `-e, --env <env_file>` (Default: .env):

Specifies the path to the env file containing your Supabase credentials (See [example.env](example.env)).  
Example: `dart run supabase_codegen:generate_types -e .env.local`

- `-o, --output <output_folder>` (Default: supabase/types):

Sets the directory where the generated type files will be placed.  
Example: `dart run supabase_codegen:generate_types -o lib/models/supabase`

- `-t, --tag <tag>` (Default: ''):

Adds a tag to the generated files to help with versioning or distinguishing between different schemas.  
Example: `dart run supabase_codegen:generate_types -t v2`  

If set, the tag will appear at the end of the files following the file generation timestamp like this
```dart 
/// Generated by supabase_codegen (0.1.0+1)
/// Date: 2025-03-06 15:43:24.078502
/// Tag: v2
```

- `-d, --debug` (Default: false):

Enables debug logging to provide more verbose output during the type generation.  
Example: `dart run supabase_codegen:generate_types -d`

## Configuration via pubspec.yaml
Instead of providing the options via the command line, you can also set them in your `pubspec.yaml` file under the supabase_codegen key. This allows setting default values, and you only need to override them if needed from the command line.

Here's an example of how to configure the options in `pubspec.yaml`:

```yaml 
name: my_supabase_app
description: A sample Supabase app.

dev_dependencies:
  supabase_codegen: ^latest_version

supabase_codegen:
  env: .env.development # Overrides default: .env
  output: lib/models/supabase # Overrides default: supabase/types
  tag: v1 # Overrides default: ''
  debug: false # Overrides default: false
```

### Explanation (See [Command Line Options](#command-line-options)):

`env`: Sets the default path to the env file.  
`output`: Sets the default output folder.  
`tag`: Sets the default tag that will be added to the generated files.  
`debug`: Sets the default for debug logging.  

### Priority 
The command line options have higher priority than the options defined in the pubspec.yaml.

## 📦 Generated Types

The generator will create strongly-typed models like this:

```dart
enum UserRole {
  admin,
  user,
}

/// Users Table
class UsersTable extends SupabaseTable<UsersRow> {
  /// Table Name
  @override
  String get tableName => 'users';

  /// Create a [UsersRow] from the [data] provided
  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow.fromJson(data);
}

/// Users Row
class UsersRow extends SupabaseDataRow {
  /// Users Row
  UsersRow({
    required String email,
    required UserRole role,
    String? id,
    String? accName,
    String? phoneNumber,
    List<String>? contacts,
    DateTime? createdAt,
  }) : super({
          'email': supaSerialize(email),
          'role': supaSerialize(role),
          if (id != null) 'id': supaSerialize(id),
          if (accName != null) 'acc_name': supaSerialize(accName),
          if (phoneNumber != null) 'phone_number': supaSerialize(phoneNumber),
          if (contacts != null) 'contacts': supaSerialize(contacts),
          if (createdAt != null) 'created_at': supaSerialize(createdAt),
        });

  /// Users Row
  const UsersRow._(super.data);

  /// Create Users Row from a [data] map
  factory UsersRow.fromJson(Map<String, dynamic> data) => UsersRow._(data);

  /// Get the [SupabaseTable] for this row
  @override
  SupabaseTable get table => UsersTable();

  /// Id field name
  static const String idField = 'id';

  /// Id
  String get id => getField<String>(idField, defaultValue: '')!;
  set id(String value) => setField<String>(idField, value);

  /// Email field name
  static const String emailField = 'email';

  /// Email
  String get email => getField<String>(emailField)!;
  set email(String value) => setField<String>(emailField, value);

  /// Acc Name field name
  static const String accNameField = 'acc_name';

  /// Acc Name
  String? get accName => getField<String>(accNameField);
  set accName(String? value) => setField<String>(accNameField, value);

  /// Phone Number field name
  static const String phoneNumberField = 'phone_number';

  /// Phone Number
  String? get phoneNumber => getField<String>(phoneNumberField);
  set phoneNumber(String? value) => setField<String>(phoneNumberField, value);

  /// Contacts field name
  static const String contactsField = 'contacts';

  /// Contacts
  List<String> get contacts => getListField<String>(contactsField);
  set contacts(List<String>? value) =>
      setListField<String>(contactsField, value);

  /// Role field name
  static const String roleField = 'role';

  /// Role
  UserRole get role =>
      getField<UserRole>(roleField, enumValues: UserRole.values)!;
  set role(UserRole value) => setField<UserRole>(roleField, value);

  /// Created At field name
  static const String createdAtField = 'created_at';

  /// Created At
  DateTime get createdAt =>
      getField<DateTime>(createdAtField, defaultValue: DateTime.now())!;
  set createdAt(DateTime value) => setField<DateTime>(createdAtField, value);

  /// Make a copy of the current [UsersRow] overriding the provided fields
  UsersRow copyWith({
    String? email,
    UserRole? role,
    String? id,
    String? accName,
    String? phoneNumber,
    List<String>? contacts,
    DateTime? createdAt,
  }) =>
      UsersRow(
        email: email ?? this.email,
        role: role ?? this.role,
        id: id ?? this.id,
        accName: accName ?? this.accName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        contacts: contacts ?? this.contacts,
        createdAt: createdAt ?? this.createdAt,
      );
}

```

## 🚀 Usage Examples

### Creating Records

```dart
final usersTable = UsersTable();

// Create new record
final adminUser = await usersTable.insert({
  UsersRow.emailField: 'john@example.com',
  UsersRow.roleField: UserRole.admin.name,
  UsersRow.accNameField: 'John Doe',
  UsersRow.phoneNumberField: '+1234567890',
});

// The returned object is already typed
print(adminUser.email);
print(adminUser.accName);

/// Create new record with row object
final user = UsersRow(
  email: 'user@example.com',
  role: UserRole.user,
  accName: 'Regular User',
  contacts: [
    adminUser.email,
  ],
);

await usersTable.insertRow(user);
```

### Reading Data

```dart
final usersTable = UsersTable();

// Fetch a single user
final user = await usersTable.querySingleRow(
  queryFn: (q) => q.eq(UsersRow.idField, 123),
);

// Access typed properties
print(user.email);
print(user.accName);
print(user.phoneNumber);
print(user.createdAt);

// Fetch multiple users
final adminUsers = await usersTable.queryRows(
  queryFn: (q) => q
  .eq(UsersRow.roleField, UserRole.admin.name)
  .order(UserRow.emailField),
);

// Work with typed objects
for (final user in adminUsers) {
  print('User ${user.id}:');
  print('- Email: ${user.email}');
  print('- Name: ${user.accName ?? "No name set"}');
  print('- Phone: ${user.phoneNumber ?? "No phone set"}');
  print('- Created: ${user.createdAt}');
}

// Query with complex conditions
final recentUsers = await usersTable.queryRows(
  queryFn: (q) => q
  .gte(UsersRow.createdAtField, DateTime.now().subtract(Duration(days: 7)))
  .ilike(UsersRow.emailField, '%@gmail.com')
  .order(UsersRow.createdAtField, ascending: false),
);
```

### Updating Records

```dart
final usersTable = UsersTable();

// Update by query
await usersTable.update(
  data: {'acc_name': 'Jane Doe'},
  matchingRows: (q) => q.eq('id', 123),
);

// Update with return value
final updatedUsers = await usersTable.update(
  data: {'role': UserRole.admin.name},
  matchingRows: (q) => q.in_(UsersRow.idField, [1, 2, 3]),
  returnRows: true,
);
```

### Deleting Records

```dart
final usersTable = UsersTable();

// Delete single record
  await usersTable.delete(
  matchingRows: (q) => q.eq(UsersRow.idField, 123),
);

// Delete with return value
final deletedUsers = await usersTable.delete(
  matchingRows: (q) => q.eq(UsersRow.roleField, UserRole.user.name),
  returnRows: true,
);
```

### Working with Related Data

```dart
// Get a pilot and their documents
final pilotsTable = PilotsTable();
final documentsTable = DocumentsTable();

// Get pilot
final pilots = await pilotsTable.queryRows(
  queryFn: (q) => q.eq('id', pilotId),
);
final pilot = pilots.firstOrNull;

// Get related documents
if (pilot != null) {
  final documents = await documentsTable.queryRows(
    queryFn: (q) => q.eq('pilot_id', pilot.id),
  );
}
```

## 📝 Notes

- Ensure your Supabase tables have proper primary keys defined
- All generated models are null-safe
- Custom column types are supported through type converters

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

### Continuous Integration 🤖

Supabase Codegen comes with a built-in [GitHub Actions workflow][github_actions_link] powered by [Very Good Workflows][very_good_workflows_link] but you can also add your preferred CI/CD solution.

Out of the box, on each pull request and push, the CI `formats`, `lints`, and `tests` the code. This ensures the code remains consistent and behaves correctly as you add functionality or make changes. The project uses [Very Good Analysis][very_good_analysis_link] for a strict set of analysis options used by our team. Code coverage is enforced using the [Very Good Workflows][very_good_coverage_link].

---

## 📄 License

This project is licensed under the GPL-3.0 license - see the [LICENSE](LICENSE) file for details.

---

[dart_install_link]: https://dart.dev/get-dart
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows

## Attributions

Built using the great work by [Kennerd](https://github.com/Kemerd) at [Supabase Flutter Codegen](https://github.com/Kemerd/supabase-flutter-codegen)
